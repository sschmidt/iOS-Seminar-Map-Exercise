//
//  MyMapAppViewController.m
//  MyMapApp
//
//  Created by Jan Knobloch on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyMapAppViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "WildcardGestureRecognizer.h"
#import <UIKit/UIKit.h>

@implementation MyMapAppViewController
@synthesize myMapView, mytap, coordinate;

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
    
}

-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView: self.view];

    NSLog(@"x= %f",point.x);
    NSLog(@"y= %f",point.y);
    self.coordinate = [myMapView convertPoint:point toCoordinateFromView: self.view];
    
    NSLog(@"x coord= %f",self.coordinate.latitude);
    NSLog(@"y coord= %f",self.coordinate.longitude);

    
    [myMapView addAnnotation:self];
    
    
}


-(IBAction) showGarching
{
    CLLocationCoordinate2D location;
    location.latitude = 48.262423;
    location.longitude = 11.668972;
    MKCoordinateSpan span;
    
    self.coordinate = location;
    span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
    
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
    [myMapView setRegion:region animated:true];
    [myMapView regionThatFits:region];
    [myMapView addAnnotation:self];

    
}



@end