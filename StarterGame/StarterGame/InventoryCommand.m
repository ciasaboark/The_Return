//
//  InventoryCommand.m
//  StarterGame
//
//  Created by csu on 3/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "InventoryCommand.h"

@implementation InventoryCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"inventory";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    NSString* returnString = @"You look through your backpack and see:";
    
    if ([[player inventory] count] == 0) {
        returnString = @"You aren't carrying anything yet";
    } else {
        for (id key in [player inventory]) {
            Item* theItem = [[player inventory]  objectForKey: key];
            returnString = [NSString stringWithFormat:@"%@  A %@.", returnString,  [theItem name]];
        }
    }
    
    [player outputMessage: returnString];
    [player outputMessage:[NSString stringWithFormat:@"You can carry around %i more pounds.", [player maxWeight] - [player currentWeight]]];

	return NO;
}

@end
