//
//  MapAnnotation.m
//  MyMapApp
//
//  Created by Jan Knobloch on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

@synthesize coordinate;

-(MapAnnotation*)initWithCoordinate:(CLLocationCoordinate2D)annotationCoordinate {
    self.coordinate = annotationCoordinate;

    return self;
}
- (CLLocationDistance) getDistanceFrom: (MapAnnotation*) comparedAnnotation {
    // compared location
    CLLocationCoordinate2D comparedCoordinate = [comparedAnnotation coordinate];
    CLLocation *comparedLocation = [[CLLocation alloc] initWithLatitude: comparedCoordinate.latitude longitude: comparedCoordinate.longitude];

    // my location
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude: self.coordinate.latitude longitude: self.coordinate.longitude];

    // distance
    CLLocationDistance distance = [myLocation getDistanceFrom:comparedLocation];
    return distance;
}

@end