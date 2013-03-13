//
//  AppDelegate.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/5/13.
//  Copyright 2013 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameIO.h"
#import "Game.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    GameIO *gameIO;
    Game *game;
}

@property (assign) IBOutlet NSTextField *command;
@property (assign) IBOutlet NSTextFieldCell *output;

@property (assign) IBOutlet NSWindow *window;

- (IBAction)receiveCommandFrom:(id)sender;

@end
