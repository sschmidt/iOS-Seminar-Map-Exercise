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

@interface MyMapAppViewController : UIViewController <MKMapViewDelegate, UIGestureRecognizerDelegate, MKAnnotation> {
    
    MKMapView *myMapView;
    UITapGestureRecognizer *mytap;
    CLLocationCoordinate2D coordinate;
}

-(IBAction) showMap;
-(IBAction) showGarching;

@property (nonatomic, retain) IBOutlet MKMapView *myMapView;
@property (nonatomic, retain) UITapGestureRecognizer *mytap;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@end
