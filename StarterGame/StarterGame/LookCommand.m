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
        //Item* tmpItem = [[[player currentRoom] items] objectForKey: secondWord];
        Item* tmpItem = [[player currentRoom] getItem: secondWord];

        if (tmpItem == nil) {
            //the item is not in the room, perhaps it is in the players inventory?
            //tmpItem = [[player inventory] objectForKey: secondWord];
            tmpItem = [player getItem: secondWord];
            
            if (tmpItem == nil) {
                //the item does not exist here
                [player outputMessage:[NSString stringWithFormat:@"\nI searched the room for some time, but can not find a %@\n", secondWord]];
            } else {
                //looking at an item in the inventory
                [player outputMessage:[NSString stringWithFormat:@"\n%@\n", [tmpItem description]]];
            }
        } else {
            //looking at an item in the room
            //We will need to append hidden item descriptions to the items description
            NSString* itemDesc = [NSString stringWithString:[tmpItem description]];
            
            //If this item has points associated with it they need to be added to the players total
            [player addPoints:[tmpItem points]];
            [tmpItem setPoints:0];
            
            //If this item has some hidden items inside we need to add those items to the room, then remove them from
            //+ this item.
            //As per the Apple API enumeration should not be done on an array that will be changed during enumeration
            //+ so we get to do this the ugly way.
            Item* hiddenItem = [[tmpItem hiddenItems] lastObject];
            [hiddenItem retain];
            while (hiddenItem != nil) {
                itemDesc = [NSString stringWithFormat:@"%@ %@", itemDesc, [hiddenItem roomDescription]];
                //[[[player currentRoom] items] setObject:hiddenItem forKey:[hiddenItem name]];
                [[player currentRoom] addItem: hiddenItem];
                //[[tmpItem hiddenItems] removeObject: hiddenItem];
                [tmpItem removeHiddenItem: hiddenItem];

                [hiddenItem release];
                hiddenItem = [[tmpItem hiddenItems] lastObject];
                [hiddenItem retain];
            }
            [hiddenItem release];
            
            [player outputMessage: [NSString stringWithFormat:@"\n%@\n",itemDesc]];
            
        }
        
	} else {
        //player wants a description of the current room and visible items

        //Build a string for native items and a string for dropped items
        NSString* droppedText = @"";
        NSString* nativeItemText = @"";
        
        for (NSString* key in [[player currentRoom] items])  {
            Item* thisItem = [[[player currentRoom] items] objectForKey: key];
            
            if ([thisItem visibleWhenPointsEqual] <= [player points]) {
                if ([thisItem isDropped]) {
                    droppedText = [NSString stringWithFormat:@"%@ A %@.", droppedText, [thisItem name]];
                } else {
                    nativeItemText = [NSString stringWithFormat:@"%@ %@", nativeItemText, [thisItem roomDescription]];
                }
            }
            
        }
        
        
        if ([droppedText length] > 1) {
            droppedText = [NSString stringWithFormat:@"\n\nIn a pile in the middle of the room I saw: %@", droppedText];
        }
        
        [player outputMessage: [NSString stringWithFormat:@"\nI was in %@. %@%@%@\n", [player currentRoom], [[player currentRoom] longDescription], nativeItemText, droppedText]];
        
    }
    
    return NO;
}

@end
