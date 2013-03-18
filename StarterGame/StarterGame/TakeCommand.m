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

        } else {
            //the item exists
            if ([itemToTake weight] + [player currentWeight] > [player maxWeight] ) {
                //but the item is too heavy
                [player outputMessage:[NSString stringWithFormat:@"You try to lift the %@, but it does not budge.  Perhaps you are carrying too much.", secondWord]];
                 
            } else if ([itemToTake weight] < 0) {
                [player outputMessage:@"How could you take that?"];
                 
            
            } else {
                //we can take the item
                [[[player currentRoom] items] removeObjectForKey: secondWord];    //remove the item from the room
                [[player inventory] setObject: itemToTake forKey: secondWord];      //and place it in the players inventory
                [itemToTake setIsDropped:false];
                [player setCurrentWeight: [player currentWeight] + [itemToTake weight]];
                
                //give some fancy feedback if this was the first item we picked up
                if ([player hasTakenItem] == false ) {
                    [player outputMessage: [NSString stringWithFormat:@"You search for something to carry the %@ in but find nothing.  Your pants, once fine, are torn, and seem to have been made without pockets.  You take off your coat and, with a little work, fashion a crude backpack of sorts, hoping that the %@ will remain secure.", secondWord, secondWord]];
                    [player setHasTakenItem: true];
                } else {                    
                    [player outputMessage: [NSString stringWithFormat:@"You place the %@ in your backpack.", secondWord]];
                }
                
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
