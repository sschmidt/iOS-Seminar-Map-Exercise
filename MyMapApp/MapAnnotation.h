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
}

- (MapAnnotation*) initWithCoordinate: (CLLocationCoordinate2D) annotationCoordinate;
- (CLLocationDistance) getDistanceFrom: (MapAnnotation*) comparedAnnotation;

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end
