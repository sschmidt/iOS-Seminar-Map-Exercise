//
//  LocationQuestionDatabase.m
//  MyMapApp
//
//  Created by Jan Knobloch on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationQuestionDatabase.h"
#import "LocationQuestion.h"


@implementation LocationQuestionDatabase
@synthesize allquestionsarray;
int mCurrentQuestion = 0;

-(void) initialiseQuestionDatabase
{

    LocationQuestion *q1 = [[[LocationQuestion alloc]init] autorelease];
    LocationQuestion *q2 = [[[LocationQuestion alloc]init] autorelease];
    LocationQuestion *q3 = [[[LocationQuestion alloc]init] autorelease];
    LocationQuestion *q4 = [[[LocationQuestion alloc]init] autorelease];
    LocationQuestion *q5 = [[[LocationQuestion alloc]init] autorelease];
    LocationQuestion *q6 = [[[LocationQuestion alloc]init] autorelease];
    LocationQuestion *q7 = [[[LocationQuestion alloc]init] autorelease];
    
    //Garching (48.262745, 11.66726)
    CLLocationCoordinate2D locationq1;
    locationq1.latitude = 48.262745;
    locationq1.longitude = 11.66726;
    q1.question = @"Please Locate Garching?";
    q1.answer = locationq1;

    
    //tokio (35.68853320738875, 139.691162109375)
    CLLocationCoordinate2D locationq2;
    locationq2.latitude = 35.68853320738875;
    locationq2.longitude = 139.691162109375;
    q2.question = @"Please Locate Tokyo?";
    q2.answer = locationq2;

    //Ouagadougou (12.364637, -1.533864)
    CLLocationCoordinate2D locationq3;
    locationq3.latitude = 12.364637;
    locationq3.longitude = -1.533864;
    q3.question = @"Please Locate Ouagadougou?";
    q3.answer = locationq3;

    //Northeim (51.707717, 10.000538)
    CLLocationCoordinate2D locationq4;
    locationq4.latitude = 51.707717;
    locationq4.longitude = 10.000538;
    q4.question = @"Please Locate Northeim?";
    q4.answer = locationq4;

    //New York(40.714353, -74.005973)
    CLLocationCoordinate2D locationq5;
    locationq5.latitude = 40.714353;
    locationq5.longitude = -74.005973;
    q5.question = @"Please Locate New York?";
    q5.answer = locationq5;
    
    //Sao Paulo (-23.548943, -46.638818)
    CLLocationCoordinate2D locationq6;
    locationq6.latitude = -23.548943;
    locationq6.longitude = -46.638818;
    q6.question = @"Please Locate Sao Paulo?";
    q6.answer = locationq6;

    //Sydney (-33.88295731069691, 151.20758056640625)
    CLLocationCoordinate2D locationq7;
    locationq7.latitude = -33.88295731069691;
    locationq7.longitude = 151.20758056640625;
    q7.question = @"Please Locate Sydney?";
    q7.answer = locationq7;

    
    
    allquestionsarray = [[NSMutableArray alloc] initWithObjects:q1,q2,q3,q4,q5,q6,q7,nil];

    
}


-(LocationQuestion*) getNextQuestion
{
    mCurrentQuestion = (mCurrentQuestion +1) % [self.allquestionsarray count];
    LocationQuestion *question = [self.allquestionsarray objectAtIndex:mCurrentQuestion];
    return question;
}

-(LocationQuestion*) getCurrentQuestion
{
    LocationQuestion *question = [self.allquestionsarray objectAtIndex:mCurrentQuestion];
    return question;
}

@end
