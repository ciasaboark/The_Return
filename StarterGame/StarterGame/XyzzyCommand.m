//
//  XyzzyCommand.m
//  StarterGame
//
//  Created by Student2 on 3/20/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "XyzzyCommand.h"

@implementation XyzzyCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"xyzzy";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	NSMutableDictionary* theRooms = [[NSMutableDictionary alloc] init];
    [theRooms setObject:[player currentRoom] forKey:@"previous"];
    [theRooms setObject:[player startRoom] forKey:@"current"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidEnterRoom" object:[player startRoom] userInfo:[theRooms autorelease]];

    [player setCurrentRoom: [player startRoom]];
    //the player is jumping all the way back to the start room, so no need for a back command now
    [player clearRoomStack];
    [player outputMessage:[NSString stringWithFormat:@"\nAs I stepped forward my vision faded, and I found myself back in %@\n", [player startRoom]]];
    
	return NO;
}

@end
