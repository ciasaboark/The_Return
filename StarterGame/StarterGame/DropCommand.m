//
//  DropCommand.m
//  StarterGame
//
//  Created by Student2 on 3/16/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "DropCommand.h"

@implementation DropCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"drop";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        //check the current room to see if the item exist
        
        id itemToDrop = [[player inventory] objectForKey: secondWord];
        [itemToDrop retain];
        
        if (itemToDrop == nil ) {
            //the item is not in the players inventory
            [player outputMessage:[NSString stringWithFormat:@"You don't have a %@ to drop.", [itemToDrop name]]];
            
        } else {
            [itemToDrop setIsDropped:YES];
            //add item to the current room
            [[[player currentRoom] items] setObject: itemToDrop forKey: [itemToDrop name]];
            //remove item from player
            [[player inventory] removeObjectForKey:[itemToDrop name]];
            //lighten the load a bit
            [player setCurrentWeight: [player currentWeight] - [itemToDrop weight]];
            
        }
        
        [itemToDrop release];
	}
	else {
        [player outputMessage:@"\nDrop what?"];
	}
	return NO;
}

@end
