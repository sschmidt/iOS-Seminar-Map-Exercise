//
//  WildcardGestureRecognizer.m
//  Created by Raymond Daly on 10/31/10.
//  Copyright 2010 Floatopian LLC. All rights reserved.
//

#import "WildcardGestureRecognizer.h"


@implementation WildcardGestureRecognizer
@synthesize touchesBeganCallback;

-(id) init{
    if (self == [super init])
    {
        self.cancelsTouchesInView = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TOUCH!!!");
    
    if (touchesBeganCallback)
        touchesBeganCallback(touches, event);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"TOUCH CANCELD!!!");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"TOUCH END!!!");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"TOUCH MOVED!!!");
}

- (void)reset
{
}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event
{
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return NO;
}

@end