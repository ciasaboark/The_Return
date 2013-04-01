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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerWillExitRoom" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerWillEnterRoom" object:nextRoom];
            [self pushRoom: currentRoom];
            [self setCurrentRoom:nextRoom];
            
            //We can pretty things up a bit by using some random verbs
            NSArray *verbs = [NSArray arrayWithObjects: @"entered", @"walked into", @"made my way to", nil];
            //unsigned long rand = arc4random_uniform([verbs count]);
            int rand = arc4random() % [verbs count];

            
            [self outputMessage:[NSString stringWithFormat:@"\nI %@ %@.\n", [verbs objectAtIndex: rand], nextRoom]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidExitRoom" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidEnterRoom" object:nextRoom];
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
    
}

-(Boolean)hasItem:(NSString*) itemName {
    Boolean playerHasItem = false;
    return playerHasItem;
}

-(Item*)removeItem:(NSString*) itemName {
    return nil;
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