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
	}
    
	return self;
}

-(void)walkTo:(NSString *)direction
{
	Room *nextRoom = [currentRoom getExit:direction];
	if (nextRoom) {
		[self setCurrentRoom:nextRoom];
        [self outputMessage:[NSString stringWithFormat:@"\n%@", nextRoom]];
	}
	else {
        [self outputMessage:[NSString stringWithFormat:@"\nThere is no door on %@!", direction]];
	}

}

-(void)outputMessage:(NSString *)message
{
    [io sendLines:message];
}

-(void)dealloc
{
	[currentRoom release];
    [io release];
	
	[super dealloc];
}

@end
