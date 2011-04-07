//
//  MapAnnotation.h
//  MyMapApp
//
//  Created by Jan Knobloch on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    int color;
}

- (MapAnnotation*) initWithCoordinateAndColor: (CLLocationCoordinate2D) annotationCoordinate: (int) color;
- (CLLocationDistance) getDistanceFrom: (MapAnnotation*) comparedAnnotation;

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) int color;

@end
