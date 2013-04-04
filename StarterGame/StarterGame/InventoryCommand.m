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
    NSString* returnString = @"\nI looked through my backpack and saw:";
    
    //if ([[player inventory] count] == 0) {
    if ([player invSize == 0]) {
        returnString = @"\nI wasn't carrying anything yet.";
    } else {
        for (id key in [player inventory]) {
            //Item* theItem = [[player inventory]  objectForKey: key];
            Item* theItem = [player getItem: key];
            returnString = [NSString stringWithFormat:@"%@ A %@.", returnString,  [theItem name]];
        }
    }
    
    [player outputMessage: [NSString stringWithFormat:@"%@\n",returnString]];
    int remaining_weight = [player maxWeight] - [player currentWeight];
    if (remaining_weight < 10 ) {
        [player outputMessage:@"I wasn't sure how much more I could carry.\n"];
    } else if (remaining_weight < 20) {
        [player outputMessage:@"My load was becomming heavy.\n"];
    } else {
        [player outputMessage:@"I could still move lightly.\n"];
    }
        
    //[player outputMessage:[NSString stringWithFormat:@"You can carry around %i more pounds.", [player maxWeight] - [player currentWeight]]];

	return NO;
}

@end
