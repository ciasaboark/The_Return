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
                    
                    //use the key here
                    
                }
                
                else if (secondWord == @"axe") {
                    //use the axe here
                }
            }
        } else {
            [player outputMessage:[NSString stringWithFormat:@"You do not have a %@", secondWord]];
        }
    } else {
        [player outputMessage:@"\nUse what?"];
	}
	return NO;
}
@end
