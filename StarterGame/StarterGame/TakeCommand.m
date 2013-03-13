//
//  TakeCommand.m
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "TakeCommand.h"

@class Item;

@implementation TakeCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"take";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        //check the current room to see if the item exist
        
        Item* itemToTake = [[[player currentRoom] items] objectForKey: secondWord];
        if (itemToTake == nil ) {
            //the item is not in the room
            [player outputMessage:@"That items does not exist here"];
//        } else if ([itemToTake weight] == -1) {
//            //the item is fixed to the room
//            [player outputMessage:[NSString stringWithFormat:@"You try to lift the %@, but it doesn't budge", secondWord]];
        } else {
            //the item exists
            if ([itemToTake weight] + [player currentWeight] > [player maxWeight] ) {
                //but the item is too heavy
                [player outputMessage:[NSString stringWithFormat:@"You try to lift the %@, but it does not budge.  Perhaps you are carrying too much.", secondWord]];
            } else {
                //the item is not too heavy
                [[[player currentRoom] items] removeObjectForKey: secondWord];    //remove the item from the room
                [[player inventory] setObject: itemToTake forKey: secondWord];      //and place it in the players inventory
                [player setCurrentWeight: [player currentWeight] + [itemToTake weight]];
                [player outputMessage: [NSString stringWithFormat:@"You place the %@ in your backpack", secondWord]];
                
                if ([player maxWeight] - [player currentWeight] < 10) {
                    //the player is close to being over-encumbered
                    [player outputMessage:@"Your backpack rest uncomfortably on your back.  You aren't sure how much more you can carry."];
                }
            }
        }
	}
	else {
        [player outputMessage:@"\nTake what?"];
	}
	return NO;
}

@end
