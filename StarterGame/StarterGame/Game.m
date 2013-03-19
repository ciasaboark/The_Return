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

-(NSArray *)createWorld {
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

    
    /************************
    * Long Descriptions of the Rooms
    ************************/

    //The Downstairs rooms
    [mast_bed setLongDescription: @"The room is dimly lit.  Windows along the east of the room are curtained and shuttered. To the north there looks to be a bathroom.  Dust motes float in the stale air."];
    
    [hall1 setLongDescription: @"The hallway is lit by two small windows flanking the main entrance to the south.  The floor is bare wood, dark in color.  The front door is large and barricaded.  You won't be able to remove the boards with your bare hands.  To the east there is a dining room.  To the west there is a formal hall.  The hall continues to the north, where you can see additonal rooms."];

    [hall2 setLongDescription: @"The hallway is contines north and south from here.  The southern end leads to the front door as well as two additional rooms.  To the north the hallway enters shadow.  To the east there is a bedroom.  To the west there is some sort of library. There is a stairway here leading to the second floor."];

    [hall3 setLongDescription: @"There isn't much light at the northern end of the hallway.  To the west there is a kitchen.  The light from the oven spills into the hall, but the penumbra is large.  To the east there is a small room with a plain wooden table.  To the north there is a plain door."];
    
    [dining_room setLongDescription: @""];
    [formal_room setLongDescription: @"A formal room of some type.  Chairs line the north and south walls, and the floor is a polished marble, white specaled with pink.  A crystal chandaleer, old enough to have once held a multitude of candles, but now fitted with electric lights, hangs from ceiling."];
    
    [sitting_room setLongDescription: @"A library of some kind.  The western wall is filled with bookcases from floor to ceiling, except for a small window in the center of the wall.  Above the door there is a marble bust of some long forgotten poet."];
    [kitchen setLongDescription: @"The northern and western walls of the kitchen are lined with counter-tops and cabinets.  The southern wall has two sinks.  One deep enough to hold a number of lenins, the other smaller.  The center of the room is dominated with a long counter over which there hangs a number of pots, pans, and utensiles.  A small Franklin stove is in the south eastern corner, next to the oven.  A small fire in the oven sheds enough light through the grating to cast shadows throughout the room."];
    [mast_bath setLongDescription: @"The master bathroom is spotless white tile.  A window along the eastern wall lets in some light from a gas lamp by the street.  The bathtub, a clawed-foot monstrosity, sits on a raised platform by the western wall.  It has been fitted with copper pipes."];
    [srvnt_dining_room setLongDescription: @""];
    [well_house setLongDescription: @""];

    //The Basement Rooms
    [cave setLongDescription: @"At the bottom of the well you find yourself in a cave of some sorts.  Light filters down from the well, but the walls seem to glow with a faint light.  It is hards to see any details, but the glow illuminates a passage north."];

    //The Upstairs Rooms
    [bed1 setLongDescription: @""];
    [bed2 setLongDescription: @""];
    [bed3 setLongDescription: @""];
    [bathroom setLongDescription: @""];
    [upstairs_hall setLongDescription: @""];
    [short_hall setLongDescription: @""];
    [storage setLongDescription: @""];
    [srvnt_bed_room setLongDescription: @""];


    /*****************************
    * Items for the rooms
    *****************************/

    //Items in the Master Bedroom
        //fixed items
        Item* master_bedroom_bed = [[Item alloc] initWithName:@"bed" andDescription:@"The BED is large and seems to be made entirely out of some glossy dark wood.  The covers are unmade.  For some reason the unmade covers seem to fill you with dispair." usedIn:nil andWeight:40 andRoomDescription:@"The little light that filters through illuminates a large four post BED draped in what looks to be velvet."];
        
        //items with hidden items
        Item* master_bedroom_dresser = [[Item alloc] initWithName:@"dresser" andDescription:@"The DRESSER is large and made in the Victorian fassion.  Sitting on top of the dresser there is a KEY" usedIn:nil andWeight:40 andRoomDescription:@"A heavy DRESSER sits along the western wall."];
            //Items on the dresser
            Item* key = [[Item alloc] initWithName:@"key" andDescription:@"A brass KEY.  The shine is tarnished. " usedIn:sitting_room andWeight:1 andRoomDescription:@"key room description here."];
            [[master_bedroom_dresser hiddenItems] addObject: [key autorelease]];

        Item* master_bedroom_closet = [[Item alloc] initWithName:@"closet" andDescription:@"The CLOSET is a mess.  Clothes are scattered all over the floor.  Searching through the mess you notice that there is a FLASHLIGHT on the top shelf." usedIn:nil andWeight:-1 andRoomDescription:@"A CLOSET is to the south."];
            //Items in the closet
            Item* flashlight = [[Item alloc] initWithName:@"flashlight" andDescription:@"An old chrome FLASHLIGHT.  You can't see how to open the battery compartment, but it feels heavy.  Maybe it will be of use somewhere." usedIn:storage andWeight:11 andRoomDescription: @"On the top shelf of the closet there is a FLASHLIGHT."];
            [[master_bedroom_closet hiddenItems] addObject: [flashlight autorelease]];

        //collectable items
        Item* hat = [[Item alloc] initWithName:@"hat" andDescription:@"A rumbled bowler HAT.  Tucked into the rim of the hat is a faded piece of paper with the numbers \"42\", \"28\", and \"16\"." usedIn:nil andWeight: 11 andRoomDescription: @"A bowlers HAT rests on a hook by the door."];
        //make the hat dropped for testing
        [hat setIsDropped:YES];
    
        [mast_bed addItem: master_bedroom_bed];
        [mast_bed addItem: master_bedroom_dresser];
        [mast_bed addItem: master_bedroom_closet];
        [mast_bed addItem: hat];
   
   //Items in the Master Bathroom
        //Fixed Items
        Item* mast_bath_tub = [[Item alloc] initWithName:@"tub" andDescription:@"" usedIn:nil andWeight:-1 andRoomDescription:@""];
        Item* mast_bath_mirror = [[Item alloc] initWithName:@"mirror" andDescription:@"" usedIn:nil andWeight:-1 andRoomDescription:@""];

        //Items with hidden items
        Item* mast_bath_shelf = [[Item alloc] initWithName:@"shelf" andDescription:@"" usedIn:nil andWeight:-1 andRoomDescription:@""];
            //Items on the shelf
            Item* razor = [[Item alloc] initWithName:@"razor" andDescription:@"" usedIn:nil andWeight:1 andRoomDescription:@""];
            [[mast_bath_shelf hiddenItems] addObject: razor];

        [mast_bath addItem: mast_bath_tub];
        [mast_bath addItem: mast_bath_mirror];
        [mast_bath addItem: mast_bath_shelf];

    //Items for the dining room
        //Fixed Items
        Item* dining_room_table = [[Item alloc] initWithName:@"table" andDescription:@"A large TABLE.  There are place-settings for four.  A large candlestick holder sits in the center.  It does not look like anyone has eaten here in years." usedIn:nil andWeight: 60 andRoomDescription:@"In the center of the room there is a large TABLE."];
        Item* dining_room_clock = [[Item alloc] initWithName:@"clock." andDescription:@"The grandfather CLOCK is large and dark.  The front panel is missing and there are gouges along the side.  The pendulum inside is still.  The marks look to have been made by some animal." usedIn:nil andWeight: 60 andRoomDescription:@"Sitting against the wall by the door there is a grandfather CLOCK."];
        Item* dining_room_china = [[Item alloc] initWithName:@"cabnet" andDescription:@"The china CABNET is filled with dishes of fine porcelain and silverware that gleams even in the dim light." usedIn:nil andWeight:60 andRoomDescription:@"In the northwest corner of the room there is a china CABNET"];
    
        [dining_room addItem: dining_room_table];
        [dining_room addItem: dining_room_clock];
        [dining_room addItem: dining_room_china];


    //Items in the library
        //Fixed items
        Item* library_book_stand = [[Item alloc] initWithName:@"stand" andDescription:@"A book STAND.  On the stand there is an open book.  The book appears to be some kind of journal.  You leaf through the pages, but, though the dates are ledgable, the text is mostly gibberish.  A single passage stands out, written in a shakey hand:\n----\nJuly 23rd 1918:\n\tSounds from below again.  The well.  The boards wont't hold forever.  Should have ended it." usedIn:nil andWeight:40 andRoomDescription:@"Against the south wall there is a book STAND with an open book on top."];

        //Items with hidden items
        Item* library_fireplace = [[Item alloc] initWithName:@"fireplace" andDescription:@"A brick FIREPLACE.  Three leather-covered chairs face the fireplace. The mantlepiece appears to be ebony.  Carved figures adorn the sides.  The brick and metal are cold, and there is not even the slightest smell of soot in the air.  The cast iron grating covers the front.  Strangely there is a lock on the cover." usedIn:nil andWeight:40 andRoomDescription:@"Along the north wall of the library there is a FIREPLACE."];
            //Items inside the fireplace
            Item* axe = [[Item alloc] initWithName:@"axe" andDescription:@"A broken AXE.  The handle is just long enough to be used as a hatchet." usedIn:hall3 andWeight:1 andRoomDescription:@"Sitting in the dust of the fireplace there is an AXE."];
            [[library_fireplace hiddenItems] addObject: axe];
        
        [sitting_room addItem: library_fireplace];
        [sitting_room addItem: library_book_stand];


    //Items in the Formal room
        //Fixed items
        Item* formal_room_record = [[Item alloc] initWithName:@"phonograph" andDescription:@"A phonograph player of older design.  Sitting next to the phonograph there are a number of records" usedIn:nil andWeight:60 andRoomDescription:@"In the middle of the western wall there is a PHONOGRAPH player.  Dispite there being no record on the player you can almost hear the music playing."];
        Item* formal_room_chairs = [[Item alloc] initWithName:@"chairs" andDescription:@"Two rows of chairs, one along the north wall, and one along the south.  The chairs are ornate, and do not look like they have seen much use.  It is obvious that the room was intended to be used for dancing and socializing." usedIn:nil andWeight:60 andRoomDescription:@"Along both the north and south wall there are rows of CHAIRS."];

        [formal_room addItem: formal_room_record];
        [formal_room addItem: formal_room_chairs];

    //Items in the kitchen
        //Fixed items
        Item* kitchen_stove = [[Item alloc] initWithName:@"stove" andDescription:@"" usedIn:nil andWeight:60 andRoomDescription:@""];
        Item* kitchen_table = [[Item alloc] initWithName:@"table" andDescription:@"" usedIn:nil andWeight:60 andRoomDescription:@""];

        //Collectable Items
        Item* knife = [[Item alloc] initWithName:@"knife" andDescription:@"" usedIn:nil andWeight:4 andRoomDescription:@""];

        [kitchen addItem: kitchen_stove];
        [kitchen addItem: kitchen_table];
        [kitchen addItem: knife];

    //Items in the servant's dining room
        //Fixed items
        Item* srvnt_dining_room_table = [[Item alloc] initWithName:@"table" andDescription:@"" usedIn:nil andWeight:60 andRoomDescription:@""];
            //Items on the servant's dining room table
             Item* lantern = [[Item alloc] initWithName:@"lantern" andDescription:@"A tin lantern.  The metal is more rust than shine, and the glass covering is chipped at the top.  There appears to be a small amount of oil in the resevoir." usedIn:kitchen andWeight:3 andRoomDescription:@"room description for the lantern"];
            [[srvnt_dining_room_table hiddenItems] addObject: lantern];

        [srvnt_dining_room addItem: srvnt_dining_room_table];


     
    //Some (collectable) Items
    //move these to appropriate rooms once the story is fleshed out.
   Item cthulhu = [[Item alloc initWithName:@"cthulhu" andDescription:@"A small jade statue of some grotesque monstrosity.  @$@#$INSERT CTHULHU DESCRIPTION HERE" usedIn:nil andWeight:3 andRoomDescription:@"" andPoints:30]];
   Item raven = [[Item alloc initWithName:@"raven" andDescription:@"A small onix statue of a raven.  The bird is carved with intricate detail." usedIn:nil andWeight:2 andRoomDescription:@"" andPoints:20]];
   Item bust = [[Item alloc initWithName:@"bust" andDescription:@"A marble bust of some long forgotten man." usedIn:nil andWeight:5 andRoomDescription:@"" andPoints: 25]];

    
     
    
    
    
    
    //In order to advance the sense of amnesia we can start in a (semi) random room.
	NSArray *rooms = [NSArray arrayWithObjects: bed1, bed2, bed3, mast_bed, mast_bath, bathroom, srvnt_bed_room, nil];
    //for (Room* aRoom in rooms) {
    //    NSLog([aRoom description]);
    //    [[[self player] sleepRooms] addObject: aRoom];
    //}
    
    //[player setSleepRooms:[NSMutableArray arrayWithArray:rooms]];
   
    //uint32_t rand = arc4random_uniform([rooms count]);

    //return [rooms objectAtIndex: rand];
    return rooms;
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
