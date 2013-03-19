//
//  TakeCommand.m
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "SleepCommand.h"

@class Item;

@implementation SleepCommand

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
    [player setCurrentRoom: [player startRoom]];
    [player outputMessage:[NSString stringWithFormat:@"As you step forward your vision fades, and find yourself back in %@", [player startRoom]]];
 
	return NO;
}

@end
