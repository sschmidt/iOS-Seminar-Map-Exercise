//
//  WinViewController.h
//  MyMapApp
//
//  Created by Martin Perzl on 08.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface WinViewController : UIViewController {
    int winner;
    UILabel *winnerLabel;
    AVAudioPlayer *audioPlayer;

}

- (IBAction)clickTheButton:(id)sender;

@property (nonatomic,readwrite) int winner;
@property (nonatomic, retain) IBOutlet UILabel *winnerLabel;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;


@end
