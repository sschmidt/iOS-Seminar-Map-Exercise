//
//  LocationQuestion.h
//  MyMapApp
//
//  Created by Martin Perzl on 07.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationQuestion : NSObject {
    NSString *question;
    CLLocationCoordinate2D answer;
}

@property (nonatomic, retain) NSString *question;
@property (nonatomic, readwrite) CLLocationCoordinate2D answer;


@end



