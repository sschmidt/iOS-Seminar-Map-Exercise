//
//  MyMapAppViewController.m
//  MyMapApp
//
//  Created by Jan Knobloch on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyMapAppViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface MyMapAppViewController()
    -(void) initializeMap;
    -(void) loadQuestions;
    -(void) showFirstQuestion;
@end


@implementation MyMapAppViewController
@synthesize myMapView, myquesitonarray, questionLabel, playerLabel, currentQuestion, myPress, nextButton, playerCount, currentPlayer, playerScores, guessedLocations, currentGameState, questions, currentAnnotations; //changeMapType;

- (void)dealloc {
    self.myPress = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeMap];
    
    self.questions = [[[LocationQuestionDatabase alloc] init] autorelease];
    
    [questions initialiseQuestionDatabase];
    
    currentGameState = START;
    
    self.playerCount = 2;
    self.currentAnnotations = [[NSMutableArray alloc] init];
    self.playerScores = malloc(playerCount * sizeof(int));
    self.guessedLocations = malloc(playerCount * sizeof(CLLocationCoordinate2D));
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
    return YES;
}

- (void) initializeMap
{
    self.myPress = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
    [myMapView addGestureRecognizer:myPress];

    myPress.delegate = self;
    myMapView.mapType = MKMapTypeSatellite;
}


-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    if(currentGameState == QUESTION_ASKED){

        CGPoint point = [recognizer locationInView: self.view];
        CLLocationCoordinate2D coordinate = [myMapView convertPoint:point toCoordinateFromView: self.view];
    
        MapAnnotation *guessedPosition = [[MapAnnotation alloc] initWithCoordinate: coordinate];
        [myMapView addAnnotation: guessedPosition];
        
        [currentAnnotations addObject:guessedPosition];
    
        guessedLocations[currentPlayer] = [myMapView convertPoint:point toCoordinateFromView: self.view];
        [nextButton setTitle:@"set Pin as answer" forState:UIControlStateNormal];
        [nextButton setEnabled:true];
        nextButton.alpha = 1.0;
        currentGameState = PIN_SET;
    }
}

- (IBAction)nextButtonPressed:(id)sender{
    NSLog(@"nextButton pressed!");
    
    if(currentGameState == START) {
        currentQuestion = [questions getNextQuestion];
        NSLog(@"Next question: %@", currentQuestion.question);
        
        MKCoordinateRegion overview = {{0.0f, 0.0f}, {0.0f, 180.0f}}; // set Latitude Delta to 180
        [myMapView setRegion: overview animated: YES];
        
        currentPlayer = 0;
        [questionLabel setText:currentQuestion.question];
        [playerLabel setText:[NSString stringWithFormat:@"Player %i's turn", currentPlayer+1]];
        currentGameState = QUESTION_ASKED;
        [nextButton setEnabled:false];
        [nextButton setTitle:@"Place Pin now" forState:UIControlStateNormal];
        nextButton.alpha = 0.5;
        NSLog(@"new state: asked");
        return;
    }
    
    if(currentGameState == QUESTION_ASKED) {
        NSLog(@"staying in state: asked");
        return;
    }
    
    // show whole world
    
    if(currentGameState == PIN_SET) {
        
        if(currentPlayer < playerCount){
            currentPlayer++;
            [playerLabel setText:[NSString stringWithFormat:@"Player %i's turn", currentPlayer+1]];
            NSLog(@"%i", currentPlayer);
            [nextButton setEnabled:false];
//            nextButton.currentTitle = @"Place Pin now";
            [nextButton setTitle:@"Place Pin now" forState:UIControlStateNormal];
            nextButton.alpha = 0.5;

            MKCoordinateRegion overview = {{0.0f, 0.0f}, {0.0f, 180.0f}}; // set Latitude Delta to 180
            [myMapView setRegion: overview animated: YES];
            
            currentGameState = QUESTION_ASKED;

            for(int i=0; i < currentAnnotations.count; i++) {
                [myMapView removeAnnotation: [currentAnnotations objectAtIndex:i]];
            }

            NSLog(@"new state: asked");
        }
        
        if(currentPlayer >= playerCount) {
            int shortestDistance = 2147483647;
            int bestPlayer = 0;
            for(int i=0; i<playerCount; i++){
                MapAnnotation *correctPosition = [[MapAnnotation alloc] initWithCoordinate: [currentQuestion answer]];
                MapAnnotation *guessedPosition = [[MapAnnotation alloc] initWithCoordinate: guessedLocations[i]];
                CLLocationDistance distance = [guessedPosition getDistanceFrom: correctPosition] / 1000;
                if(distance < shortestDistance){
                    shortestDistance = distance;
                    bestPlayer = i;
                }
            }
            
            NSString *message = [NSString stringWithFormat:@"Player %i won! (%i km)", bestPlayer + 1, shortestDistance];
            
            MKCoordinateRegion overview = {[currentQuestion answer], {0.0f, 100.0f}}; // set Latitude Delta to 180
            [myMapView setRegion: overview animated: YES];

            
            [nextButton setEnabled:true];
            [questionLabel setText: message];
            [nextButton setTitle:@"next Question" forState:UIControlStateNormal];
            nextButton.alpha = 1.0;
            
            MapAnnotation *solution = [[MapAnnotation alloc] initWithCoordinate: currentQuestion.answer];
            [currentAnnotations addObject:solution];
            [myMapView addAnnotation:solution];
            
            for(int i=0; i < currentAnnotations.count; i++) {
                [myMapView addAnnotation: [currentAnnotations objectAtIndex:i]];
            }

            currentGameState = SHOW_ANSWER;
            currentPlayer = 0;
            [playerLabel setText:@""];
            NSLog(@"new state: answer");
        }
        
        return;
    }

    if(currentGameState == SHOW_ANSWER){
        currentQuestion = [questions getNextQuestion];
        [questionLabel setText:currentQuestion.question];
        [nextButton setEnabled:false];
        [nextButton setTitle:@"Place Pin now" forState:UIControlStateNormal];
        nextButton.alpha = 0.5;
        
        currentPlayer = 0;
        [playerLabel setText:[NSString stringWithFormat:@"Player %i's turn", currentPlayer+1]];

        currentGameState = QUESTION_ASKED;
        
        for(int i=0; i < currentAnnotations.count; i++) {
            [myMapView removeAnnotation: [currentAnnotations objectAtIndex:i]];
        }
        
        [currentAnnotations removeAllObjects];
        
        NSLog(@"new state: asked");
    }
}



@end
