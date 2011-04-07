//
//  LocationQuestionDatabase.h
//  MyMapApp
//
//  Created by Jan Knobloch on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationQuestion.h"

@interface LocationQuestionDatabase : NSObject {
    
    NSMutableArray *allquestionsarray;
}

-(LocationQuestion*) getNextQuestion;
-(void) initialiseQuestionDatabase;
-(LocationQuestion*) getCurrentQuestion;

@property (nonatomic,retain) NSMutableArray *allquestionsarray;

@end
