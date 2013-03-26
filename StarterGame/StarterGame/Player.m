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
        unsigned long rand = arc4random_uniform([rooms count]);
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
            [self outputMessage:[NSString stringWithFormat:@"\nThe path %@ is blocked.  Perhaps there is a way around?", direction]];
        } else if ([[nextRoom tag] isEqualToString:@"locked"] ) {
            [self outputMessage:[NSString stringWithFormat:@"\nThe door %@ is locked.  Perhaps there is a key?", direction]];
        } else if ([[nextRoom tag] isEqualToString:@"dark"] ) {
            [self outputMessage:[NSString stringWithFormat:@"\nThe way %@ is too dark to proceed.", direction]];
        } else {
            [[self roomStack] addObject: currentRoom];
            [self setCurrentRoom:nextRoom];
            
            //We can pretty things up a bit by using some random verbs
            NSArray *verbs = [NSArray arrayWithObjects: @"enter", @"walk into", @"make your way to", nil];
            unsigned long rand = arc4random_uniform([verbs count]);

            
            [self outputMessage:[NSString stringWithFormat:@"\nYou %@ %@.\n", [verbs objectAtIndex: rand], nextRoom]];
        }
	} else {
        [self outputMessage:[NSString stringWithFormat:@"\nThere is no path %@!", direction]];
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