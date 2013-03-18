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
        Item* tmpItem = [[[player currentRoom] items] objectForKey: secondWord];

        if (tmpItem == nil) {
            //the item is not in the room, perhaps it is in the players inventory?
            tmpItem = [[player inventory] objectForKey: secondWord];
            
            if (tmpItem == nil) {
                //the item does not exist here
                [player outputMessage:[NSString stringWithFormat:@"You search the room for some time, but can not find a %@", secondWord]];
            } else {
                //looking at an item in the inventory
                [player outputMessage:[NSString stringWithFormat:@"Looking at the %@ in your backpack you see: %@", [tmpItem name], [tmpItem description]]];
            }
        } else {
            //looking at an item in the room
            [player outputMessage:[NSString stringWithFormat:@"Looking at the %@ in the room you see: %@", [tmpItem name], [tmpItem description]]];
            
            //If this item has some hidden items inside we need to add those items to the room, then remove them from
            //+ this item.
            //As per the Apple API enumeration should not be done on an array that will be changed during enumeration
            //+ so we get to do this the ugly way.
            Item* hiddenItem = [[tmpItem hiddenItems] lastObject];
            while (hiddenItem != nil) {
                [[player currentRoom] addItem: hiddenItem];
                [[tmpItem hiddenItems] removeObject: hiddenItem];
                //move to the next object (or nil)
                hiddenItem = [[tmpItem hiddenItems] lastObject];
            }
        }
        //[tmpItem release];
	} else {
        //player wants a description of the current room and known item

        //Build a string for native items and a string for dropped items
        NSString* droppedText = @"";
        NSString* nativeItemText = @"";
        
        for (NSString* key in [[player currentRoom] items])  {
            Item* thisItem = [[[player currentRoom] items] objectForKey: key];
            
            if ([thisItem isDropped]) {
                droppedText = [NSString stringWithFormat:@"%@  A %@.", droppedText, key];
            } else {
                nativeItemText = [NSString stringWithFormat:@"%@  %@", nativeItemText, [thisItem roomDescription]];
            }
            
        }
        
        
        if ([droppedText length] > 1) {
            droppedText = [NSString stringWithFormat:@"\nIn a pile in the middle of the room you see: %@", droppedText];
        }
        
        [player outputMessage: [NSString stringWithFormat:@"You are in %@.  %@  %@  %@", [player currentRoom], [[player currentRoom] longDescription], [nativeItemText autorelease], [droppedText autorelease]]];
        
    }
    
    return NO;
}

@end
