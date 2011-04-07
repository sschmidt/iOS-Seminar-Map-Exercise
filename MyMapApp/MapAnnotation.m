//
//  MapAnnotation.m
//  MyMapApp
//
//  Created by Jan Knobloch on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

@synthesize coordinate, color;

-(MapAnnotation*)initWithCoordinateAndColor:(CLLocationCoordinate2D)annotationCoordinate:(int)annotationColor {
    self.coordinate = annotationCoordinate;
    self.color = annotationColor;
    return self;
}


- (CLLocationDistance) getDistanceFrom: (MapAnnotation*) comparedAnnotation {

    // compared location
    CLLocationCoordinate2D comparedCoordinate = [comparedAnnotation coordinate];
    CLLocation *comparedLocation = [[CLLocation alloc] initWithLatitude: comparedCoordinate.latitude longitude: comparedCoordinate.longitude];

    // my location
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude: self.coordinate.latitude longitude: self.coordinate.longitude];

    // distance
    CLLocationDistance distance = [myLocation distanceFromLocation:comparedLocation];
    return distance;
}

@end
