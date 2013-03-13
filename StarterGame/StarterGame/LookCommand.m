//
//  LookCommand.m
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "LookCommand.h"

@implementation LookCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"look";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		//This is where we would describe an item
        [player outputMessage: @"This is where an item from the room or inventory would be described"];
	}
	else {
        [player outputMessage:[NSString stringWithFormat:@"You are in %@. %@", [player currentRoom], [[player currentRoom] longDescription]]];
	}
	return NO;
}

@end
