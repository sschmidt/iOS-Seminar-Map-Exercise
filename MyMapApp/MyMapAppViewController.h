//
//  MyMapAppViewController.h
//  MyMapApp
//
//  Created by Jan Knobloch on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationGetter.h"


@interface MyMapAppViewController : UIViewController <MKMapViewDelegate, UIGestureRecognizerDelegate, MKAnnotation, LocationGetterDelegate> {
    
    MKMapView *myMapView;
    UITapGestureRecognizer *mytap;
    CLLocationCoordinate2D coordinate;
    UISegmentedControl *changeMapType;
    LocationGetter *myLocationGetter;
    CLLocation *lastKnownPhysicalLocation;
}

-(IBAction) showMap;
-(IBAction) showGarching;
-(IBAction) changeType: (id) sender;


@property (nonatomic, retain) IBOutlet MKMapView *myMapView;
@property (nonatomic, retain) UITapGestureRecognizer *mytap;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) IBOutlet UISegmentedControl *changeMapType;
@property (nonatomic, retain) LocationGetter *myLocationGetter;
@property (nonatomic, retain) CLLocation *lastKnownPhysicalLocation;
@end
