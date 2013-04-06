//
//  Player.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Player.h"


@implementation Player

@synthesize currentRoom;
@synthesize io;
@synthesize inventory;
@synthesize maxWeight;
@synthesize currentWeight;
@synthesize sleepRooms;
@synthesize hasTakenItem;
@synthesize startRoom;
@synthesize roomStack;
@synthesize points;

-(id)init
{
	return [self initWithRoom:nil andIO:nil];
}

-(id)initWithRoom:(NSMutableArray *)rooms andIO:(GameIO *)theIO
{
	self = [super init];
    
	if (nil != self) {
        int rand = arc4random() % [rooms count];
		[self setCurrentRoom:[rooms objectAtIndex:rand]];

        [self setStartRoom: currentRoom];
        [self setIo:theIO];
        inventory = [[NSMutableDictionary alloc] init];
        [self setMaxWeight: 30];
        [self setCurrentWeight: 0];
        [self setSleepRooms: rooms];
        [self setHasTakenItem: false];
        roomStack = [[NSMutableArray alloc] init];
	}
    
	return self;
}

-(void)walkTo:(NSString *)direction
{
	Room *nextRoom = [currentRoom getExit:direction];
    if (nextRoom) {
        if ([[nextRoom tag] isEqualToString:@"blocked"] ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathBlocked" object:self];
            [self outputMessage:[NSString stringWithFormat:@"\nThe path %@ was blocked.  But there might have been a way around.\n", direction]];
        } else if ([[nextRoom tag] isEqualToString:@"locked"] ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathLocked" object:self];
            [self outputMessage:[NSString stringWithFormat:@"\nThe door %@ was locked.  There might have been a key.\n", direction]];
        } else if ([[nextRoom tag] isEqualToString:@"dark"] ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathDark" object:self];
            [self outputMessage:[NSString stringWithFormat:@"\nThe way %@ was too dark to proceed.\n", direction]];
        } else {            
            //We will pass this dictionary to the notifications to simplify the logic within
            //+ the soundServer.
            NSMutableDictionary* theRooms = [[NSMutableDictionary alloc] init];
            [theRooms setObject:currentRoom forKey:@"previous"];
            [theRooms setObject:nextRoom forKey:@"current"];


            [self pushRoom: currentRoom];
            [self setCurrentRoom:nextRoom];
            
            //We can pretty things up a bit by using some random verbs
            NSArray *verbs = [NSArray arrayWithObjects: @"entered", @"walked into", @"made my way to", nil];
            int rand = arc4random() % [verbs count];

            
            [self outputMessage:[NSString stringWithFormat:@"\nI %@ %@.\n", [verbs objectAtIndex: rand], nextRoom]];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidRoomTransition" object:self userInfo:theRooms];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidEnterRoom" object:nextRoom];
            [theRooms autorelease];
        }
	} else {
        [self outputMessage:[NSString stringWithFormat:@"\nThere was no path %@.\n", direction]];
	}

}

-(void)outputMessage:(NSString *)message
{
    [io sendLines:message];
}


-(void)addItem:(Item*) anItem {
    if (anItem != nil) {
        [inventory setObject: anItem forKey: [anItem name]];
    }
}

-(BOOL)hasItem:(NSString*) itemName {
    BOOL response = NO;
    if ([[self inventory] objectForKey: itemName] != nil) {
        response = YES;
    }

    return response;
}

-(Item*)getItem:(NSString*)itemName {
    Item* theItem = [inventory objectForKey: itemName];
    [theItem retain];
    return [theItem autorelease];
}

-(Item*)removeItem:(NSString*) itemName {
    Item* theItem = [[self inventory] objectForKey: itemName];
    [theItem retain];
    [inventory removeObjectForKey: itemName];
    [self setCurrentWeight: [player currentWeight] - [theItem weight]];

    return [theItem autorelease];
}

-(unsigned long)invSize {
    return [inventory count];
}


-(void)addPoints:(int) morePoints {
    [self setPoints: points + morePoints];
}

-(void)pushRoom:(Room*)aRoom {
    [[self roomStack] addObject: aRoom];
}

-(Room*)popRoom {
    Room* theRoom = [[self roomStack] lastObject];
    [theRoom retain];
    [[self roomStack] removeLastObject];
    return [theRoom autorelease];
}

-(void)clearRoomStack {
    [[self roomStack] removeAllObjects];
}

-(void)dealloc
{
	[currentRoom release];
    [io release];
    [inventory release];
    [sleepRooms release];
    [startRoom release];
    [roomStack release];
         
	[super dealloc];
}

@end