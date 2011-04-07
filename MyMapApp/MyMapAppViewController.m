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
@synthesize myMapView, mytap, myquesitonarray, questionLabel, currentQuestion; //changeMapType;

- (void)dealloc {
    self.mytap = nil;
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
    self.mytap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
    [myMapView addGestureRecognizer:mytap];

    mytap.delegate = self;
    myMapView.mapType = MKMapTypeHybrid;
}

- (void) loadQuestions
{

    LocationQuestion *q1 = [[LocationQuestion alloc]init];

    CLLocationCoordinate2D location;
    location.latitude = 48.262423;
    location.longitude = 11.668972;

    q1.question = @"Wo ist Garching";
    q1.answer = location;
    
    myquesitonarray = [[NSMutableArray alloc] initWithObjects:q1, nil];
    
}

-(void) showFirstQuestion
{

    [questionLabel setText:[[myquesitonarray objectAtIndex:0] question]];  
    self.currentQuestion = [myquesitonarray objectAtIndex:0];
}


-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView: self.view];
    CLLocationCoordinate2D coordinate = [myMapView convertPoint:point toCoordinateFromView: self.view];
    
    MapAnnotation *guessedPosition = [[MapAnnotation alloc] initWithCoordinate: coordinate];
    [myMapView addAnnotation: guessedPosition];

    MapAnnotation *correctPosition = [[MapAnnotation alloc] initWithCoordinate: [currentQuestion answer]];
    
    [myMapView addAnnotation: guessedPosition];
    [myMapView addAnnotation: correctPosition];
    
    CLLocationDistance distance = [guessedPosition getDistanceFrom: correctPosition] / 1000;
    NSString *message = [NSString stringWithFormat:@"Du lagst %f km daneben!", distance];

    [questionLabel setText: message];
}



@end
