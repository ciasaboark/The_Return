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

-(id)init
{
	return [self initWithRoom:nil andIO:nil];
}

-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO
{
	self = [super init];
    
	if (nil != self) {
		[self setCurrentRoom:room];
        [self setIo:theIO];
        inventory = [[NSMutableDictionary alloc] init];
        maxWeight = 30;
        currentWeight = 0;
	}
    
	return self;
}

-(void)walkTo:(NSString *)direction
{
	Room *nextRoom = [currentRoom getExit:direction];
	if (nextRoom) {
		if (nextRoom == nil) {
            [self outputMessage:@"The path is blocked."];
        } else {
            [self setCurrentRoom:nextRoom];
            
            //We can pretty things up a bit by using some random verbs
            NSArray *verbs = [NSArray arrayWithObjects: @"enter", @"walk into", @"make your way to", nil];
            uint32_t rand = arc4random_uniform([verbs count]);

            
            [self outputMessage:[NSString stringWithFormat:@"\nYou %@ %@.\n", [verbs objectAtIndex: rand], nextRoom]];
        }
	}
	else {
        [self outputMessage:[NSString stringWithFormat:@"\nThere is no path %@!", direction]];
	}

}

-(void)outputMessage:(NSString *)message
{
    [io sendLines:message];
}

-(void)addToInventory:(Item*) anItem {
    if (anItem != nil) {
        [inventory setObject: anItem forKey: [anItem name]];
    }
}

-(void)dealloc
{
	[currentRoom release];
    [io release];
	
	[super dealloc];
}

@end
