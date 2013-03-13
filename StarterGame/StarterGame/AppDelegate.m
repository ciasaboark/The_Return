//
//  AppDelegate.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/5/13.
//  Copyright 2013 Columbus State University. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize command;
@synthesize output;

- (void)dealloc
{
    [gameIO release];
    [game release];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    gameIO = [[GameIO alloc] initWithOutput:output andNumberOfLines:15];
    game = [[Game alloc] initWithGameIO:gameIO];
    [game start];
}

- (IBAction)receiveCommandFrom:(id)sender {
    if ([game execute: [sender stringValue]]) {
        [game end];
    }
    [sender setStringValue:@""];
}
@end
