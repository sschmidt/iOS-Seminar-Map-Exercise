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

@implementation MyMapAppViewController
@synthesize myMapView, mytap, myLocationGetter, lastKnownPhysicalLocation, myquesitonarray, questionLabel, currentQuestion; //changeMapType;

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
    [self showMap];
    [self loadQuestions];
    [self showFirstQuestion];
    
    // get physical location
    myLocationGetter = [[LocationGetter alloc] init];
    myLocationGetter.delegate = self;
    [myLocationGetter startUpdates];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction) showMap
{
    // (48.262423, 11.668972)
    self.mytap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
    [myMapView addGestureRecognizer:mytap];
    NSLog(@"Show my map");
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

-(IBAction) showFirstQuestion
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


-(IBAction) showGarching
{
    CLLocationCoordinate2D location;
    location.latitude = 48.262423;
    location.longitude = 11.668972;
    MKCoordinateSpan span;
        span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
    
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
    [myMapView setRegion:region animated:true];
    [myMapView regionThatFits:region];

}
//
//- (IBAction) changeType:(id) sender{
//    if(changeMapType.selectedSegmentIndex == 0){
//        myMapView.mapType = MKMapTypeStandard;
//    }
//    else if (changeMapType.selectedSegmentIndex == 1){
//        myMapView.mapType = MKMapTypeSatellite;
//    }
//    else if (changeMapType.selectedSegmentIndex == 2){
//        myMapView.mapType = MKMapTypeHybrid;
//    }
//
//}

- (void)newPhysicalLocation:(CLLocation *) location{
    // test the age of the location, because the device automatically caches locations
    NSTimeInterval locationAge = -[location.timestamp timeIntervalSinceNow];
    if (locationAge > 2.0){
        NSLog(@"alt: %f", locationAge);
    }
    else{
        NSLog(@"Setting new Location. locationAge %f", locationAge);
        self.lastKnownPhysicalLocation = location;
        
        //if a valid update is received, stop the updates
        [[myLocationGetter locationManager] stopUpdatingLocation];
    }
}


@end
