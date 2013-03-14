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
            id instance = [[[[[player currentRoom] items] objectForKey: secondWord] hiddenItems] lastObject];
            while (instance != nil) {
                [[player currentRoom] addItem: instance];
                [[[[player currentRoom] items] objectForKey: secondWord] removeObject: instance];
                //move to the next object (or nil)
                instance = [[[[[player currentRoom] items] objectForKey: secondWord] hiddenItems] lastObject];
            }
	} else {
        //player wants a description of the current room and known items
        [player outputMessage:[NSString stringWithFormat:@"You are in %@. %@", [player currentRoom], [[player currentRoom] longDescription]]];

        //describe native items in the room (one per line)
        //dropped items are added to a string to be printed later
        NSMutableString* droppedText = @"";
        for (id instance in [[player currentRoom] items]  {
            // tempString = [NSString stringWithFormat:@"%@ Card%i:\"%@\"", tempString, ++i, instance ];
            if ([instance isDropped]) {
                droppedText = [NSString stringWithFormat:@"%@ %@", droppedText, [instance name]]
            } else {
                [player outputMessage: [NSString stringWithFormat:@"%@\n", [instance roomDescription]]];
            }
        }

        //list dropped items in a single block of text
        if ([droppedText length] > 1) {
            [player outputMessage: [NSString stringWithFormat:@"In a pile in the middle of the room you see: %@", droppedText]];
        }
   
	return NO;
}

@end
