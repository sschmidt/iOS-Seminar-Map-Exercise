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
@synthesize myMapView, myquesitonarray, questionLabel, currentQuestion, myPress, nextButton, playerCount, currentPlayer, playerScores, guessedLocations, currentGameState, questions, currentAnnotations; //changeMapType;

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
    [self loadQuestions];
    [self showFirstQuestion];
    
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
    myMapView.delegate = self;
}

- (void) loadQuestions
{

    LocationQuestion *q1 = [[LocationQuestion alloc]init];

    CLLocationCoordinate2D location;
    location.latitude = 48.262423;
    location.longitude = 11.668972;

    q1.question = @"Please push the Start Button";
    q1.answer = location;
    
    myquesitonarray = [[NSMutableArray alloc] initWithObjects:q1, nil];
    
}

-(void) showFirstQuestion
{

    [questionLabel setText:[[myquesitonarray objectAtIndex:0] question]];  
    self.currentQuestion = [myquesitonarray objectAtIndex:0];
}


- (MKAnnotationView *) mapView:(MKMapView *) mapView viewForAnnotation:(id<MKAnnotation>) annotation {
    NSLog(@"new pin detected");
    {

        MKPinAnnotationView	*importantView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier :	@"importantView" ] ; 
        if (importantView == nil) {
            importantView	=	[[[MKPinAnnotationView alloc] initWithAnnotation : annotation	reuseIdentifier :@"importantView" ]	autorelease ] ;
            importantView.animatesDrop = YES;
            importantView.draggable = YES;

        }

        MapAnnotation *test = (MapAnnotation*) annotation;
        int color = test.color;
        NSLog(@"color %i",color);
        if (color == 0)
        {
            importantView.pinColor = MKPinAnnotationColorRed;
        }
        if (color == 1)
        {
            importantView.pinColor = MKPinAnnotationColorPurple;
        }
        if (color == 2)
        {
            importantView.pinColor = MKPinAnnotationColorGreen;
        }
        
    importantView.annotation = annotation; 
    importantView.canShowCallout = NO;
    return importantView;  
    } 
    return nil ;
    }
    
    
    
    
    
    
    
    -(void) handleTap:(UITapGestureRecognizer *)recognizer
    {
        if(currentGameState == QUESTION_ASKED){
            currentGameState = PIN_SET; 
            CGPoint point = [recognizer locationInView: self.view];
            CLLocationCoordinate2D coordinate = [myMapView convertPoint:point toCoordinateFromView: self.view];
            
            MapAnnotation *guessedPosition = nil;
            
            if (currentPlayer == 0)
            {
            guessedPosition = [[MapAnnotation alloc] initWithCoordinateAndColor:coordinate :0];
            }    
            else if (currentPlayer == 1)
            {
            guessedPosition = [[MapAnnotation alloc] initWithCoordinateAndColor:coordinate :1];
            }    
            else
            {
            guessedPosition = [[MapAnnotation alloc] initWithCoordinateAndColor:coordinate :2];
            }
            [myMapView addAnnotation: guessedPosition];
            [currentAnnotations addObject:guessedPosition];
            
            guessedLocations[currentPlayer] = [myMapView convertPoint:point toCoordinateFromView: self.view];
        [nextButton setTitle:@"set Pin as answer" forState:UIControlStateNormal];
        [nextButton setEnabled:true];

    }
}

- (IBAction)nextButtonPressed:(id)sender{
    NSLog(@"nextButton pressed!");
    
    if(currentGameState == START) {
        currentGameState = QUESTION_ASKED;
        currentQuestion = [questions getNextQuestion];
        NSLog(@"Next question: %@", currentQuestion.question);
        
        [questionLabel setText:currentQuestion.question];

        [nextButton setTitle:@"Place Pin now" forState:UIControlStateNormal];
        [nextButton setEnabled:false];
        currentPlayer = 0;
        NSLog(@"new state: asked");
        return;
    }
    
    if(currentGameState == QUESTION_ASKED) {
        NSLog(@"staying in state: asked");
        return;
    }
    
    if(currentGameState == PIN_SET) {
        
        if(currentPlayer < playerCount){
            currentPlayer++;
            NSLog(@"%i", currentPlayer);
            [nextButton setTitle:@"Place Pin now" forState:UIControlStateNormal];
            [nextButton setEnabled:false];
            currentGameState = QUESTION_ASKED;

            for(int i=0; i < currentAnnotations.count; i++) {
                [myMapView removeAnnotation: [currentAnnotations objectAtIndex:i]];
            }

            NSLog(@"new state: asked");
        }
        
        if(currentPlayer >= playerCount) {
            currentGameState = SHOW_ANSWER;
            float shortestDistance = 99999999999999;
            int bestPlayer = 0;
            for(int i=0; i<playerCount; i++){
                MapAnnotation *correctPosition = [[MapAnnotation alloc] initWithCoordinateAndColor:[currentQuestion answer] :2];
                MapAnnotation *guessedPosition = [[MapAnnotation alloc] initWithCoordinateAndColor:guessedLocations[i] :2 ];
                CLLocationDistance distance = [guessedPosition getDistanceFrom: correctPosition] / 1000;
                if(distance < shortestDistance){
                    shortestDistance = distance;
                    bestPlayer = i;
                }
            }
            
            NSString *message = [NSString stringWithFormat:@"Player %i hat gewonnen! (%f km)", bestPlayer + 1, shortestDistance];
            
            [questionLabel setText: message];
            [nextButton setTitle:@"next Question" forState:UIControlStateNormal];
            [nextButton setEnabled:true];
            
            MapAnnotation *solution = [[MapAnnotation alloc] initWithCoordinateAndColor:currentQuestion.answer :2];
            [currentAnnotations addObject:solution];
            [myMapView addAnnotation:solution];
            
            for(int i=0; i < currentAnnotations.count; i++) {
                [myMapView addAnnotation: [currentAnnotations objectAtIndex:i]];
            }


            currentPlayer = 0;
            NSLog(@"new state: answer");
        }
        
        return;
    }

    if(currentGameState == SHOW_ANSWER){
        currentQuestion = [questions getNextQuestion];
        [questionLabel setText:currentQuestion.question];
        [nextButton setTitle:@"Place Pin now" forState:UIControlStateNormal];
        [nextButton setEnabled:false];
        
        currentPlayer = 0;
        currentGameState = QUESTION_ASKED;
        
        for(int i=0; i < currentAnnotations.count; i++) {
            [myMapView removeAnnotation: [currentAnnotations objectAtIndex:i]];
        }
        
        [currentAnnotations removeAllObjects];
        
        NSLog(@"new state: asked");
    }
}



@end
