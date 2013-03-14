//
//  UseCommand.m
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "UseCommand.h"

@implementation UseCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"use";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        //check that the item is in the inventory
        Item* tmpItem = [[player inventory] objectForKey:secondWord];
        if (tmpItem != nil) {
            //then check that we are in the correct room to use this item
            if ([tmpItem usedIn] == [player currentRoom]) {
                //then match against known items
                //there doesn't seem to be a way to switch/case using NSStrings so get ready for some if/elses
                if (secondWord == @"lantern") {
                    //lantern
                }
                
                else if (secondWord == @"key") {
                    [player outputMessage:@"You insert the key into the rusty lock on the fireplace.  After some effort you are rewarded with the squeal of the hinges.  Resting in the ashes of the fireplace there is an axe.  The handle is splintered no more than a foot from the blade, but you might be able to use it as a hatchet.  The blade is dull, but with a little effort no door can block your path"];
                    //figure out how to add the axe here
                    
                }
                
                /*else if (secondWord == @"axe") {
                    [player outputMessge:@"You strike the door with the axe.  Chips of wood fly into the air.  Again.  Time passes.  Your arms tire.  Eventually the wood around the lock splinters.  You kick the door free and step out into the air.  As you walk from the house you ask yourself why you didn't just smash a window in the first place"];
                    //the game is over now
                }*/
            }
        }
    }
	else {
        [player outputMessage:@"\nUse what?"];
	}
	return NO;
}
@end
