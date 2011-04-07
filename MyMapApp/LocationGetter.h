//
//  LocationGetter.h
//  MyMapApp
//
//  Created by Martin Perzl on 07.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationGetterDelegate
@required
- (void) newPhysicalLocation:(CLLocation *) location;
@end


@interface LocationGetter : NSObject <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    id<LocationGetterDelegate> delegate;
}

-(void)startUpdates;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) id<LocationGetterDelegate> delegate;

@end
