//
//  LookCommand.m
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "LookCommand.h"

@implementation LookCommand

@class Item;

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
        Item* tmpItem = [[[player currentRoom] items] objectForKey: secondWord];
        if (tmpItem == nil) {
            //the item is not in the room, perhaps it is in the players inventory?
            tmpItem = [[player inventory] objectForKey: secondWord];
            
            if (tmpItem == nil) {
                //the item does not exist here
                [player outputMessage:[NSString stringWithFormat:@"You search the room for some time, but can not find a %@", secondWord]];
            } else {
                [player outputMessage:[NSString stringWithFormat:@"Looking at the %@ in your backpack you see: %@", [tmpItem name], [tmpItem description]]];
            }
        } else {
            [player outputMessage:[NSString stringWithFormat:@"Looking at the %@ in the room you see: %@", [tmpItem name], [tmpItem description]]];
        }
	}
	else {
        [player outputMessage:[NSString stringWithFormat:@"You are in %@. %@", [player currentRoom], [[player currentRoom] longDescription]]];
	}
	return NO;
}

@end
