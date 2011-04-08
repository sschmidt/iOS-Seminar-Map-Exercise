//
//  WinViewController.h
//  MyMapApp
//
//  Created by Martin Perzl on 08.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WinViewController : UIViewController {
    int winner;
    UILabel *winnerLabel;

}

- (IBAction)clickTheButton:(id)sender;

@property (nonatomic,readwrite) int winner;
@property (nonatomic, retain) IBOutlet UILabel *winnerLabel;

@end
