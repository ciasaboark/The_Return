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
	Room 	*hall1, *hall2, *hall3, *dining_room, *formal_room, *mast_bed, *sitting_room, *kitchen, *mast_bath;
    Room    *srvnt_dining_room, *well_house;

    hall1 = [[[Room alloc] initWithTag:@"the south of the downstairs hallway"] autorelease];
    hall2 = [[[Room alloc] initWithTag:@"the middle of the downstairs hallway"] autorelease];
    hall3 = [[[Room alloc] initWithTag:@"the north of the downstairs hallway"] autorelease];
    dining_room = [[[Room alloc] initWithTag:@"the dining room"] autorelease];
    formal_room = [[[Room alloc] initWithTag:@"the formal room"] autorelease];
    mast_bed = [[[Room alloc] initWithTag:@"the master bedroom"] autorelease];
    sitting_room = [[[Room alloc] initWithTag:@"the sitting room"] autorelease];
    kitchen = [[[Room alloc] initWithTag:@"the kitchen"] autorelease];
    mast_bath = [[[Room alloc] initWithTag:@"the master bathroom"] autorelease];
    srvnt_dining_room = [[[Room alloc] initWithTag:@"the servant's small dining room"] autorelease];
    well_house = [[[Room alloc] initWithTag:@"an attached well house"] autorelease];
    
    
    //The basement room
    Room 	*cave;
    
    cave = [[[Room alloc] initWithTag:@"an underground cave"] autorelease];
    
    //The upstairs rooms
	Room 	*bed1, *bed2, *bed3, *bathroom, *upstairs_hall, *short_hall, *storage, *srvnt_bed_room;

    bed1 = [[[Room alloc] initWithTag:@"a child's bedroom"] autorelease];
    bed2 = [[[Room alloc] initWithTag:@"an empty bedroom"] autorelease];
    bed3 = [[[Room alloc] initWithTag:@"an empty bedroom"] autorelease];
    bathroom = [[[Room alloc] initWithTag:@"the upstairs bath"] autorelease];
    upstairs_hall = [[[Room alloc] initWithTag:@"the upstairs hall"] autorelease];
    short_hall = [[[Room alloc] initWithTag:@"a short hall"] autorelease];
    storage = [[[Room alloc] initWithTag:@"a dark storage room"] autorelease];
    srvnt_bed_room = [[[Room alloc] initWithTag:@"the servant's bedroom"] autorelease];
    
    //Downstairs room connections
	[hall1 setExit:@"west" toRoom:dining_room];
    [hall1 setExit:@"east" toRoom:formal_room];
    [hall1 setExit:@"north" toRoom:hall2];

    [hall2 setExit:@"west" toRoom:sitting_room];
    [hall2 setExit:@"east" toRoom:mast_bed];
    [hall2 setExit:@"north" toRoom:hall3];
    [hall2 setExit:@"south" toRoom:hall1];
    [hall2 setExit:@"up" toRoom:upstairs_hall];


    [hall3 setExit:@"west" toRoom:kitchen];
    [hall3 setExit:@"east" toRoom:srvnt_dining_room];
    [hall3 setExit:@"north" toRoom:well_house];
    [hall3 setExit:@"south" toRoom:hall2];


    [dining_room setExit:@"east" toRoom:hall1];


    [formal_room setExit:@"west" toRoom:hall1];


    [mast_bed setExit:@"west" toRoom:hall2];
    [mast_bed setExit:@"north" toRoom:mast_bath];


    [sitting_room setExit:@"east" toRoom:hall2];


    [kitchen setExit:@"east" toRoom:hall3];


    [mast_bath setExit:@"south" toRoom:mast_bed];


    [srvnt_dining_room setExit:@"west" toRoom:hall3];


    [well_house setExit:@"down" toRoom:cave];
    [well_house setExit:@"south" toRoom:hall3];

	
    //Basement Connections
	[cave setExit:@"up" toRoom:well_house];

	//Upstairs Connections
    [bed1 setExit:@"west" toRoom:upstairs_hall];
    [bed1 setExit:@"north" toRoom:bathroom];

    [bed2 setExit:@"south" toRoom:bed3];
    [bed2 setExit:@"east" toRoom:short_hall];


    [bed3 setExit:@"north" toRoom:bed2];
    [bed3 setExit:@"east" toRoom:upstairs_hall];


    [bathroom setExit:@"south" toRoom:bed1];
    [bathroom setExit:@"west" toRoom:short_hall];


    [upstairs_hall setExit:@"down" toRoom:hall2];   //should this be down or north?
    [upstairs_hall setExit:@"west" toRoom:bed3];
    [upstairs_hall setExit:@"south" toRoom:storage];
    [upstairs_hall setExit:@"east" toRoom:bed1];


    [short_hall setExit:@"down" toRoom:hall2];
    [short_hall setExit:@"west" toRoom:bed2];
    [short_hall setExit:@"north" toRoom:srvnt_bed_room];
    [short_hall setExit:@"east" toRoom:bathroom];


    [storage setExit:@"north" toRoom:upstairs_hall];


    [srvnt_bed_room setExit:@"south" toRoom:short_hall];

    
    //Long Descriptions of the Rooms
    [mast_bed setLongDescription:   @"The room is dimly lit.\nWindows along the east of the room are curtained and shuttered.  The little light that filters through illuminates a large masted bed draped in what looks to be velvet.  To the north there looks to be a bathroom.  A heavy dresser sits along the western wall.  A closet is to the south.  Dust motes float in the stale air."];
    
    //Some (non-takable) Items for the rooms
    //Items for the dining room
    Item* dining_room_table = [[Item alloc] initWithName:@"the dining room table" andDescription:@"A large table.  There are place-settings for four.  A large candlestick holder sits in the center.  It does not look like anyone has eaten here in years." usedIn:nil andWeight: 40];
    Item* clock = [[Item alloc] initWithName:@"a grandfather clock." andDescription:@"Describe the grandfather clock." usedIn:nil andWeight: 40];

    [dining_room addItem: dining_room_table];
    [dining_room addItem: clock];
    
    //Items in the sitting room
    Item* fireplace = [[Item alloc] initWithName:@"fireplace" andDescription:@"A brick fireplace.  Three leather-covered chairs face the fireplace. The mantlepiece appears to be ebony.  Carved figures adorn the sides.  The brick and metal are cold, and there is not even the slightest smell of soot in the air.  The cast iron grating covers the front.  Strangely there is a lock on the cover." usedIn:nil andWeight:40];

    [sitting_room addItem: fireplace];
     
    //Some (collectable) Items
    Item* flashlight = [[Item alloc] initWithName:@"flashlight" andDescription:@"An old chrome flashlight.  You can't see how to open the battery compartment, but it feels heavy.  Maybe it will be of use somewhere." usedIn:storage andWeight:3];
    Item* key = [[Item alloc] initWithName:@"key" andDescription:@"A brass key.  The shine is tarnished. " usedIn:dining_room andWeight:20];
    Item* lantern = [[Item alloc] initWithName:@"lantern" andDescription:@"A tin lantern.  The metal is more rust than shine, and the glass covering is chipped at the top.  There appears to be a small amount of oil in the resevoir." usedIn:kitchen andWeight:3];
    
     
     [dining_room addItem: key];
     [mast_bed addItem: flashlight];
    
    
    //We can start in a (semi) random room
	NSArray *rooms = [NSArray arrayWithObjects: bed1, bed2, bed3, mast_bed, mast_bath, bathroom, srvnt_bed_room, nil];
    uint32_t rand = arc4random_uniform([rooms count]);

    return [rooms objectAtIndex: rand];
    //return mast_bed;
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
	return [NSString stringWithFormat:@"You wake.  The pain in your head begins to fade.  Looking around you see that you are in %@.\n%@  You can't remember how you got here.  Perhaps this house holds some answers.", [player currentRoom], [[player currentRoom] longDescription]];
	//return [NSString stringWithFormat:@"\n\n%@\n%@", message, [player currentRoom]];
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
