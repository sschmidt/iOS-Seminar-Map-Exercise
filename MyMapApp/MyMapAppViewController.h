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
#import "LocationQuestionDatabase.h"

enum currentGameStateEnum {START, QUESTION_ASKED, PIN_SET, SHOW_ANSWER};


@interface MyMapAppViewController : UIViewController <MKMapViewDelegate, UIGestureRecognizerDelegate> {

    
    MKMapView *myMapView;
    UILongPressGestureRecognizer *myPress;
    NSMutableArray *myquesitonarray;
    UILabel *questionLabel;
    UIButton *nextButton;
    LocationQuestion *currentQuestion;
    int playerCount;
    int currentPlayer;
    int *playerScores; //array
    CLLocationCoordinate2D *guessedLocations; //array
    enum currentGameStateEnum currentGameState;
    LocationQuestionDatabase *questions;
    NSMutableArray *currentAnnotations;
   
}

@property (nonatomic, retain) IBOutlet MKMapView *myMapView;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) UILongPressGestureRecognizer *myPress;
@property (nonatomic, retain) NSMutableArray *myquesitonarray;
@property (nonatomic, retain) LocationQuestion *currentQuestion;
@property (nonatomic, assign) int playerCount;
@property (nonatomic, assign) int currentPlayer;
@property (nonatomic, assign) int *playerScores;
@property (nonatomic, readwrite) CLLocationCoordinate2D *guessedLocations;
@property (nonatomic, assign) enum currentGameStateEnum currentGameState;
@property (nonatomic, retain) LocationQuestionDatabase *questions;
@property (nonatomic, retain) NSMutableArray *currentAnnotations;

@end
