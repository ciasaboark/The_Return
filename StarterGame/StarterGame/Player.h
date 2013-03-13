//
//  Player.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import <Cocoa/Cocoa.h>
#import "Room.h"
#import "GameIO.h"


@interface Player : NSObject

@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)GameIO *io;

-(id)init;
-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO;
-(void)walkTo:(NSString *)direction;
-(void)outputMessage:(NSString *)message;

@end
