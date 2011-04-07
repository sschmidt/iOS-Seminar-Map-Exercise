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
#import "LocationQuestion.h"
#import "MapAnnotation.h"


@interface MyMapAppViewController : UIViewController <MKMapViewDelegate, UIGestureRecognizerDelegate> {

    
    
    MKMapView *myMapView;
    UITapGestureRecognizer *mytap;
    NSMutableArray *myquesitonarray;
    UILabel *questionLabel;
    LocationQuestion *currentQuestion;
    


   
}

@property (nonatomic, retain) IBOutlet MKMapView *myMapView;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) UITapGestureRecognizer *mytap;
@property (nonatomic, retain) NSMutableArray *myquesitonarray;
@property (nonatomic, retain) LocationQuestion *currentQuestion;

@end
