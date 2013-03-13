//
//  Game.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Game.h"


@implementation Game

@synthesize parser;
@synthesize player;

-(id)initWithGameIO:(GameIO *)theIO {
	self = [super init];
	if (nil != self) {
		[self setParser:[[[Parser alloc] init] autorelease]];
		[self setPlayer:[[[Player alloc] initWithRoom:[self createWorld] andIO:theIO] autorelease]];
        playing = NO;
	}
	return self;
}

-(Room *)createWorld {
	Room *outside, *cctParking, *boulevard, *universityParking, *parkingDeck, *cct, *theGreen, *universityHall, *schuster;
	
	outside = [[[Room alloc] initWithTag:@"outside the main entrance of the university"] autorelease];
	cctParking = [[[Room alloc] initWithTag:@"in the parking lot at CCT"] autorelease];
	boulevard = [[[Room alloc] initWithTag:@"on the boulevard"] autorelease];
	universityParking = [[[Room alloc] initWithTag:@"in the parking lot at University Hall"] autorelease];
	parkingDeck = [[[Room alloc] initWithTag:@"in the parking deck"] autorelease];
	cct = [[[Room alloc] initWithTag:@"in the CCT building"] autorelease];
	theGreen = [[[Room alloc] initWithTag:@"in the green in front of Schuster Center"] autorelease];
	universityHall = [[[Room alloc] initWithTag:@"in University Hall"] autorelease];
	schuster = [[[Room alloc] initWithTag:@"in the Schuster Center"] autorelease];
	
	[outside setExit:@"west" toRoom:boulevard];
	
	[boulevard setExit:@"east" toRoom:outside];
	[boulevard setExit:@"south" toRoom:cctParking];
	[boulevard setExit:@"west" toRoom:theGreen];
	[boulevard setExit:@"north" toRoom:universityParking];
	
	[cctParking setExit:@"west" toRoom:cct];
	[cctParking setExit:@"north" toRoom:boulevard];
	
	[cct setExit:@"east" toRoom:cctParking];
	[cct setExit:@"north" toRoom:schuster];
	
	[schuster setExit:@"south" toRoom:cct];
	[schuster setExit:@"north" toRoom:universityHall];
	[schuster setExit:@"east" toRoom:theGreen];
	
	[theGreen setExit:@"west" toRoom:schuster];
	[theGreen setExit:@"east" toRoom:boulevard];
	
	[universityHall setExit:@"south" toRoom:schuster];
	[universityHall setExit:@"east" toRoom:universityParking];
	
	[universityParking setExit:@"south" toRoom:boulevard];
	[universityParking setExit:@"west" toRoom:universityHall];
	[universityParking setExit:@"north" toRoom:parkingDeck];
	
	[parkingDeck setExit:@"south" toRoom:universityParking];
	
	return outside;
}

-(void)start
{
    playing = YES;
    [player outputMessage:[self welcome]];
}

-(void)end
{
    [player outputMessage:[self goodbye]];
    playing = NO;
}

-(BOOL)execute:(NSString *)commandString
{
	BOOL finished = NO;
    if (playing) {
        [player outputMessage:[NSString stringWithFormat:@">%@",commandString]];
        Command *command = [parser parseCommand:commandString];
        if (command) {
            finished = [command execute:player];
        }
        else {
            [player outputMessage:@"\nI dont' understand..."];
        }
    }
    return finished;
}

-(NSString *)welcome
{
	NSString *message = @"Welcome to the World of CSU!\nThe World of CSU is a new, incredibly boring adventure game.\nType 'help' if you need help.";
	return [NSString stringWithFormat:@"\n\n%@\n%@", message, [player currentRoom]];
}

-(NSString *)goodbye
{
    return @"\nThank you for playing, Goodbye.\n";
}

-(void)dealloc
{
	[parser release];
	[player release];
	
	[super dealloc];
}

@end
