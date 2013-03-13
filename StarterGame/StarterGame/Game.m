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
	//The downstairs rooms
	Room 	*hall1, *hall2, *hall3, *dining_room, *formal_room, *mast_bed, *sitting_room, *kitchen, *mast_bath
			*srvnt_dining_room, *well_house;

	hall1 = [[[Room alloc] initWithTag:@""] autorelease];
		[hall1 setExit:@"west" toRoom:dining_room];
		[hall1 setExit:@"east" toRoom:formal_room];
		[hall1 setExit:@"north" toRoom:hall2];
	
	hall2 = [[[Room alloc] initWithTag:@""] autorelease];
		[hall2 setExit:@"west" toRoom:sitting_room];
		[hall2 setExit:@"east" toRoom:mast_bed];
		[hall2 setExit:@"north" toRoom:hall3];
		[hall2 setExit:@"south" toRoom:hall1];
		[hall2 setExit:@"up" toRoom:upstairs_hall];

	hall3 = [[[Room alloc] initWithTag:@""] autorelease];
		[hall3 setExit:@"west" toRoom:kitchen];
		[hall3 setExit:@"east" toRoom:srvnt_dining_room];
		[hall3 setExit:@"north" toRoom:well_house];
		[hall3 setExit:@"south" toRoom:hall2];

	dining_room = [[[Room alloc] initWithTag:@""] autorelease];
		[dining_room setExit:@"east" toRoom:hall1];

	formal_room = [[[Room alloc] initWithTag:@""] autorelease];
		[formal_room setExit:@"west" toRoom:hall1];

	mast_bed = [[[Room alloc] initWithTag:@""] autorelease];
		[mast_bed setExit:@"west" toRoom:hall2];
		[mast_bed setExit:@"north" toRoom:mast_bath];

	sitting_room = [[[Room alloc] initWithTag:@""] autorelease];
		[sitting_room setExit:@"east" toRoom:hall2];

	kitchen = [[[Room alloc] initWithTag:@""] autorelease];
		[kitchen setExit:@"east" toRoom:hall3];

	mast_bath = [[[Room alloc] initWithTag:@""] autorelease];
		[mast_bath setExit:@"south" toRoom:mast_bed];

	srvnt_dining_room = [[[Room alloc] initWithTag:@""] autorelease];
		[srvnt_dining_room setExit:@"west" toRoom:hall3];

	well_house = [[[Room alloc] initWithTag:@""] autorelease];
		[well_house setExit:@"down" toRoom:cave];
		[well_house setExit:@"south" toRoom:hall3];

	//The basement room
	Room 	*cave;

	cave = [[[Room alloc] initWithTag@""] autorelease];
		[cave setExit:@"up" toRoom:well_house];

	//The upstairs rooms
	Room 	*bed1, *bed2, *bed3, *bathroom, *upstairs_hall, *short_hall, *storage, *srvnt_bed_room;

	bed1 = [[[Room alloc] initWithTag:@""] autorelease];
		[bed1 setExit:@"west" toRoom:upstairs_hall];
		[bed1 setExit:@"north" toRoom:bathroom];

	bed2 = [[[Room alloc] initWithTag:@""] autorelease];
		[bed2 setExit:@"south" toRoom:bed3];
		[bed2 setExit:@"east" toRoom:short_hall];

	bed3 = [[[Room alloc] initWithTag:@""] autorelease];
		[bed3 setExit:@"north" toRoom:bed2];
		[bed3 setExit:@"east" toRoom:upstairs_hall];

	bathroom = [[[Room alloc] initWithTag:@""] autorelease];
		[bathroom setExit:@"south" toRoom:bed1];
		[bathroom setExit:@"west" toRoom:short_hall];

	upstairs_hall = [[[Room alloc] initWithTag:@""] autorelease];
		[upstairs_hall setExit:@"down" toRoom:hall2];
		[upstairs_hall setExit:@"west" toRoom:bed3];
		[upstairs_hall setExit:@"south" toRoom:storage];
		[upstairs_hall setExit:@"east" toRoom:bed1];

	short_hall = [[[Room alloc] initWithTag:@""] autorelease];
		[short_hall setExit:@"down" toRoom:hall2];
		[short_hall setExit:@"west" toRoom:bed2];
		[short_hall setExit:@"north" toRoom:srvnt_bed_room];
		[short_hall setExit:@"east" toRoom:bathroom];

	storage = [[[Room alloc] initWithTag:@""] autorelease];
		[storage setExit:@"north" toRoom:upstairs_hall];

	srvnt_bed_room = [[[Room alloc] initWithTag:@""] autorelease];
		[srvnt_bed_room setExit:@"south" toRoom:short_hall];

	//We can start in a (semi) random room
	NSArray *rooms;
	rooms = [NSArray arrayWithObjects: bed1, bed2, bed3, mast_bed, mast_bath, bathroom, srvnt_bed_room];
	uint32_t rand = arc4random_uniform([tips count]);

	return [rooms objectAtIndex: rand];
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
