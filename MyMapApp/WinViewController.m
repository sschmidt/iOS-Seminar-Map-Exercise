//
//  WinViewController.m
//  MyMapApp
//
//  Created by Martin Perzl on 08.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WinViewController.h"
#import "MyMapAppViewController.h"

@implementation WinViewController
@synthesize winner, winnerLabel, audioPlayer;


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Winner: %i", winner);
    winner++;
    NSString *winnerString = [NSString stringWithFormat: @"%i", winner];
    [winnerLabel setText: winnerString];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/queenstripped.mp3", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;

    [audioPlayer play];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickTheButton:(id)sender
{
    MyMapAppViewController *controller = [[MyMapAppViewController alloc] initWithNibName:@"MyMapAppViewController" bundle:nil];
    [self presentModalViewController:controller animated:YES];
    [controller autorelease];
    [audioPlayer stop];
}

@end
