//
//  LocationGetter.m
//  MyMapApp
//
//  Created by Martin Perzl on 07.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationGetter.h"


@implementation LocationGetter
@synthesize locationManager, delegate;

-(void)startUpdates{
    NSLog(@"Starting Location Updates");
          if(locationManager == nil){
              self.locationManager = [[[CLLocationManager alloc] init] autorelease];
              locationManager.delegate = self;
              locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
              [locationManager startUpdatingLocation];
          }
}

-(void)locationManager:(CLLocationManager *) manager didFailWithError:(NSError *)error{
    NSLog(@"No location found");
    [locationManager stopUpdatingLocation];
}

// delegate method from CLLocationManagerDelegate protocol
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //call the delegate of LocationGetter protocol
    [delegate newPhysicalLocation:newLocation];
}

@end
