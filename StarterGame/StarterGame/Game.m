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
@synthesize wrongCommands;

-(id)initWithGameIO:(GameIO *)theIO {
	self = [super init];
	if (nil != self) {
        [self registerForNotifications];
		[self setParser:[[[Parser alloc] init] autorelease]];
		[self setPlayer:[[[Player alloc] initWithRoom:[self createWorld] andIO:theIO] autorelease]];
        playing = NO;
        [self setWrongCommands: 0];
	}
	return self;
}

-(NSArray *)createWorld {
	//A special room to indicate that the path is blocked
    Room* blocked = [[[Room alloc] initWithTag:@"blocked"] autorelease];

    //A special room to indicate that a door is locked
    Room* locked = [[[Room alloc] initWithTag:@"locked"] autorelease];

    //A special room to indicate that the path is too dark to proceed
    Room* dark = [[[Room alloc] initWithTag:@"dark"] autorelease];

    
    //The downstairs rooms
	Room 	*hall1, *hall2, *hall3, *dining_room, *formal_room, *mast_bed, *sitting_room, *kitchen, *mast_bath;
    Room    *srvnt_dining_room, *well_house, *front_steps;

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
    front_steps = [[[Room alloc] initWithTag:@"the front steps of the house"] autorelease];
    
    
    //The cave rooms
    Room 	*cave, *cave_hall, *cemetery;
    
    cave = [[[Room alloc] initWithTag:@"an underground cave"] autorelease];
    cave_hall = [[[Room alloc] initWithTag:@"a long underground tunnel" ] autorelease];
    cemetery = [[[Room alloc] initWithTag:@"a small family cemetery"] autorelease];
    
    //The upstairs rooms
	Room 	*bed1, *workroom, *bed3, *bathroom, *upstairs_hall, *short_hall, *sewing_room, *srvnt_bed_room, *attic;

    bed1 = [[[Room alloc] initWithTag:@"a child's bedroom"] autorelease];
    workroom = [[[Room alloc] initWithTag:@"an empty bedroom"] autorelease];
    bed3 = [[[Room alloc] initWithTag:@"an empty bedroom"] autorelease];
    bathroom = [[[Room alloc] initWithTag:@"the upstairs bath"] autorelease];
    upstairs_hall = [[[Room alloc] initWithTag:@"the upstairs hall"] autorelease];
    short_hall = [[[Room alloc] initWithTag:@"a short hall"] autorelease];
    sewing_room = [[[Room alloc] initWithTag:@"a dark end room"] autorelease];
    srvnt_bed_room = [[[Room alloc] initWithTag:@"the servant's bedroom"] autorelease];
    attic = [[[Room alloc] initWithTag:@"the attic"] autorelease];

    
    //Downstairs room connections
	[hall1 setExit:@"west" toRoom:dining_room];
    [hall1 setExit:@"east" toRoom:formal_room];
    [hall1 setExit:@"north" toRoom:hall2];
    [hall1 setExit:@"south" toRoom:blocked];
    //a hidden exit. We will use this to replace the blocked exit later.
    [hall1 setExit:@"hidden" toRoom:front_steps];

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
    
    [front_steps setExit:@"north" toRoom:hall1];

	
    //cave Connections
	[cave setExit:@"up" toRoom:well_house];
    [cave setExit:@"north" toRoom:dark];
    //a hidden path that will replace the north direction later
    [cave setExit:@"hidden" toRoom:cave_hall];
    
    [cave_hall setExit:@"south" toRoom:cave];
    [cave_hall setExit:@"west" toRoom:cemetery];
    
    [cemetery setExit:@"east" toRoom:cave_hall];

	//Upstairs Connections
    [bed1 setExit:@"west" toRoom:upstairs_hall];
    [bed1 setExit:@"north" toRoom:bathroom];

    [workroom setExit:@"south" toRoom:bed3];
    [workroom setExit:@"east" toRoom:short_hall];


    [bed3 setExit:@"north" toRoom:workroom];
    [bed3 setExit:@"east" toRoom:upstairs_hall];


    [bathroom setExit:@"south" toRoom:bed1];
    [bathroom setExit:@"west" toRoom:short_hall];


    [upstairs_hall setExit:@"down" toRoom:hall2];
    [upstairs_hall setExit:@"west" toRoom:bed3];
    //This will now be the end room
    [upstairs_hall setExit:@"south" toRoom:locked];
    [upstairs_hall setExit:@"end" toRoom:sewing_room];
    [upstairs_hall setExit:@"east" toRoom:bed1];
    [upstairs_hall setExit:@"up" toRoom:blocked];
    [upstairs_hall setExit:@"hidden" toRoom:attic];



    [short_hall setExit:@"down" toRoom:hall2];
    [short_hall setExit:@"west" toRoom:workroom];
    [short_hall setExit:@"north" toRoom:srvnt_bed_room];
    [short_hall setExit:@"east" toRoom:bathroom];


    [sewing_room setExit:@"north" toRoom:upstairs_hall];


    [srvnt_bed_room setExit:@"south" toRoom:short_hall];

    [attic setExit:@"down" toRoom:upstairs_hall];

    
    /************************
    * Long Descriptions of the Rooms
    ************************/

    //The Downstairs rooms
    [mast_bed setLongDescription: @"The room is dimly lit.  WINDOWS along the east of the room are curtained and shuttered, letting in no light from the street lamp.  The overhead light is off, but small bulbs burn in sconces on both sides of the entrance, illuminating the room. To the north there looks to be a bathroom.  The entrance to the hall is west.  Dust motes floats air."];
    
    [hall1 setLongDescription: @"The hallway is lit by two miniature chandeliers, one in this section of the hall and one somewhat farther down.  The floor is bare wood, dark in color.  The walls are white plaster, with molding that matches the floor.  The front door is large and barricaded with a number of hastily placed boards.  You won't be able to remove the barrier with your bare hands.  To the east there is a dining room.  To the west there is a formal hall.  The hallway continues to the north, where you can see additonal rooms."];

    [hall2 setLongDescription: @"The hallway is lit by a miniature chandelier overhead.  The walls are white plaster with dark wood molding and the floor, a dark stained wood in the style of the molding, is covered by a long rug woven in some Oriential style.  The hallway continues north and south from here.  The southern end leads to the front door as well as two additional rooms.  To the north the hallway enters shadow.  To the east there is a bedroom.  To the west there is some sort of library. There is a stairway here leading up to the second floor."];

    [hall3 setLongDescription: @"There isn't much light at the northern end of the hallway.  To the west there is a kitchen.  Light from within spills into the hall, but the penumbra is large.  To the east there is a small room with a plain wooden table.  To the north there is a plain door."];
    
    [dining_room setLongDescription: @"The light from the hallway illuminates an ornate and formal dining room.  Nearly the entirity of the floor is covered by a single large rug, woven with a mozaic of birds in flight.  A long table sits in the center of the room, with a number of elegantly carved chairs waiting in position.  Each chair is fronted by a complete table set.  Curiously the two on the southern end seem to have been used recently."];
    [formal_room setLongDescription: @"A formal room of some type.  Chairs line the north and south walls, and the floor is a polished marble, white specaled with pink.  A crystal chandaleer, old enough to have once held a multitude of candles, but now fitted with electric lights, hangs from ceiling."];
    
    [sitting_room setLongDescription: @"A library of some kind.  The western wall is filled with bookcases from floor to ceiling, except for a small window in the center of the wall.  Above the door there is a marble bust of some long forgotten poet."];
    [kitchen setLongDescription: @"The northern and western walls of the kitchen are lined with counter-tops and cabinets.  The southern wall has two sinks.  One deep enough to hold a number of lenins, the other smaller.  The center of the room is dominated with a long counter over which there hangs a number of pots, pans, and utensiles.  A small Franklin stove is in the south eastern corner, next to the oven.  A small fire in the oven sheds enough light through the grating to cast shadows throughout the room."];
    [mast_bath setLongDescription: @"The master bathroom is spotless white tile.  A window along the eastern wall lets in some light from a gas lamp by the street."];
    [srvnt_dining_room setLongDescription: @"There is no light source within this room, but the glow from the kitchen stretches far enough in to see by.  The small room is dominated by a square TABLE.  A single chair is pushed against the table.  This looks to be where a servent might take their meal so as not to disturb the master of the house."];
    [well_house setLongDescription: @"A small rectangular room.  The floor here is bare wood, but unstained.  A long window high on the northern wall lets in enough light to see.  In the northeast corner of the room there is an uncovered WELL.  It seems as though this room was added as an expansion sometime recently.  A sturdy rope hangs from a pully connected to a large beam overhead."];
    [front_steps setLongDescription:@""];

    //The Basement Rooms
    [cave setLongDescription: @"Light filters down from the well, but not enough to see by.  If only you had some source of light to illuminate the way."];
    [cave_hall setLongDescription:@"The cave ends to the south in a small chamber, and continues north."];
    [cemetery setLongDescription:@"The cemetery is a small family plot.  There are no more than a dozen graves, most of which seem to be long neglected.  A dense forest encloses the opening."];

    //The Upstairs Rooms
    [bed1 setLongDescription: @""];
    [workroom setLongDescription: @""];
    [bed3 setLongDescription: @""];
    [bathroom setLongDescription: @""];
    [upstairs_hall setLongDescription: @""];
    [short_hall setLongDescription: @""];
    [sewing_room setLongDescription: @"The room is lit by a single bulb, almost burned out.  In the dim light you behold a grim sight.  In the middle of the room there is a WOMAN.  Pale golden hair hangs loose covering her face.  The front of her dress is splashed in crimson.  Her feet drag on the ground as her body gently swings fron a noose.  Beside her,  on the ground, there is a small BODY.  The appalling vision is so overwhelming that you almost miss seeing movement in the corner."];
    [srvnt_bed_room setLongDescription: @""];


    /*****************************
    * Items for the rooms
    *****************************/

    //Items in the Master Bedroom
        //fixed items
        Item* master_bedroom_bed = [[Item alloc] initWithName:@"bed" andDescription:@"The BED is large and seems to be made entirely out of some glossy dark wood.  The covers are unmade.  For some reason this seems to fill you with dispair." usedIn:nil andWeight:40 andRoomDescription:@"The little light that filters through illuminates a large four post BED draped in what looks to be velvet."];
        Item* master_bedroom_windows = [[Item alloc] initWithName:@"windows" andDescription:@"The windows are curtained in heavy purple cloth.  They seem familiar, or, to be more precise, you feel as though they should feel familiar." usedIn:nil andWeight:60 andRoomDescription:@""];
        Item* master_bedroom_couch = [[Item alloc] initWithName:@"couch" andDescription:@"The couch is made from a dark wood, intricately carved on the legs and back.  The cushions are uphostered in a red velvet." usedIn:nil andWeight:60 andRoomDescription:@"A COUCH shares the wall with the bathroom entrance."];
        
        //items with hidden items
        Item* master_bedroom_dresser = [[Item alloc] initWithName:@"dresser" andDescription:@"The DRESSER is large and made in the Victorian fassion.  Sitting on top of the dresser there is a KEY" usedIn:nil andWeight:40 andRoomDescription:@"A heavy DRESSER sits along the western wall."];
            //Items on the dresser
            Item* key = [[Item alloc] initWithName:@"key" andDescription:@"A brass KEY.  The shine is tarnished. " usedIn:upstairs_hall andWeight:1 andRoomDescription:@"key room description here."];
            [[master_bedroom_dresser hiddenItems] addObject: [key autorelease]];

        Item* master_bedroom_closet = [[Item alloc] initWithName:@"closet" andDescription:@"The CLOSET is a mess.  Clothes are scattered all over the floor.  Searching through the mess you notice that there is a FLASHLIGHT on the top shelf." usedIn:nil andWeight:-1 andRoomDescription:@"A CLOSET is to the south."];
            //Items in the closet
            Item* flashlight = [[Item alloc] initWithName:@"flashlight" andDescription:@"An old chrome FLASHLIGHT.  You can't see how to open the battery compartment, but it feels heavy.  Maybe it will be of use somewhere." usedIn:sewing_room andWeight:2 andRoomDescription: @"On the top shelf of the closet there is a FLASHLIGHT."];
            [[master_bedroom_closet hiddenItems] addObject: [flashlight autorelease]];

        //collectable items
        Item* hat = [[Item alloc] initWithName:@"hat" andDescription:@"A rumbled bowler HAT.  Tucked into the rim of the hat is a faded piece of paper with the numbers \"42\", \"28\", and \"16\"." usedIn:nil andWeight:2 andRoomDescription:@"A bowlers HAT rests on a hook by the door."];
    
        [mast_bed addItem: master_bedroom_bed];
        [mast_bed addItem: master_bedroom_windows];
        [mast_bed addItem: master_bedroom_couch];
        [mast_bed addItem: master_bedroom_dresser];
        [mast_bed addItem: master_bedroom_closet];
        [mast_bed addItem: hat];
   
   //Items in the Master Bath
        //Fixed Items
        Item* mast_bath_tub = [[Item alloc] initWithName:@"tub" andDescription:@"A glazed, cast iron, clawed-foot monstrosity.  It has been re-fitted with copper pipes." usedIn:nil andWeight:-1 andRoomDescription:@"There is a TUB on a raised platform by the western wall."];
        
    
        Item* mast_bath_mirror = [[Item alloc] initWithName:@"mirror" andDescription:@"A broken mirror.  You can't see any blood on the glass shards.  The frame has spots of mud along the sides." usedIn:nil andWeight:6 andRoomDescription:@"The MIRROR that was once above the sink lies shattered on the floor."];

        //Items with hidden items
        Item* mast_bath_shelf = [[Item alloc] initWithName:@"shelf" andDescription:@"A shelf of white wood." usedIn:nil andWeight:-1 andRoomDescription:@"A SHELF above the sink holds a few items."];
            //Items on the shelf
            Item* razor = [[Item alloc] initWithName:@"razor" andDescription:@"A straight razor.  The handle is ivory.  It seems to be sharp, but there are small spots of rust on the blade." usedIn:nil andWeight:1 andRoomDescription:@"A RAZOR is on the shelf."];
            [[mast_bath_shelf hiddenItems] addObject: razor];

        [mast_bath addItem: mast_bath_tub];
        [mast_bath addItem: mast_bath_mirror];
        [mast_bath addItem: mast_bath_shelf];

    //Items for the dining room
        //Fixed Items
        Item* dining_room_table = [[Item alloc] initWithName:@"table" andDescription:@"A large TABLE.  There is still platters of half eaten food on two of the settings.  A bowl leans at a angle, soup covering the tablecloth." usedIn:nil andWeight: 60 andRoomDescription:@"In the center of the room there is a large TABLE."];
        Item* dining_room_clock = [[Item alloc] initWithName:@"clock." andDescription:@"The grandfather CLOCK is large and dark.  The front panel is missing and there are gouges along the side.  The pendulum inside is still.  The marks look to have been made by some animal." usedIn:nil andWeight: 60 andRoomDescription:@"Sitting against the wall by the door there is a grandfather CLOCK."];
        Item* dining_room_china = [[Item alloc] initWithName:@"cabinet" andDescription:@"The china CABINET is filled with dishes of fine porcelain and silverware that gleams even in the dim light." usedIn:nil andWeight:60 andRoomDescription:@"  A large china CABINET has been placed along the center of the western wall, flanked on either side by serving trays."];
    
        [dining_room addItem: dining_room_table];
        [dining_room addItem: dining_room_clock];
        [dining_room addItem: dining_room_china];


    //Items in the library
        //Items with hidden items
        Item* library_book_stand = [[Item alloc] initWithName:@"stand" andDescription:@"A book STAND.  On the stand there is an open book.  The book appears to be some kind of journal.  A page is open, weighted down by a carved raven.  Though the dates on the page are ledgable, the text is mostly gibberish.  A single passage stands out, written in a shakey hand:\n----\nJuly 23rd 1918:\n\tSounds from below again.  The well.  The boards wont't hold forever.  Should have ended it." usedIn:nil andWeight:40 andRoomDescription:@"Against the south wall there is a book STAND with an open book on top."];
            //Items on the book stand
            Item* raven = [[Item alloc] initWithName:@"raven" andDescription:@"A small black onyx carving of a raven.  The birds beak is open, as if caught in a moment of speech." usedIn:nil andWeight:3 andRoomDescription:@"" andPoints: 0 andSpecial:true];
            [[library_book_stand hiddenItems] addObject:raven];
        
         Item* library_book_stack = [[Item alloc] initWithName:@"stack" andDescription:@"A large STACK of book.  You look through the titles and notice some obscure subjects:\nThe OCCULT of New Haven\nOn the Religion of Papa New GUINEA\nRituals and Practices of IRAM of the Pillars." usedIn:nil andWeight:-1 andRoomDescription:@"On a table beside the chairs there is a large STACK of books."];
            //Books in the stack
            Item* book_stack_occult = [[Item alloc] initWithName:@"occult" andDescription:@"" usedIn:nil andWeight:3 andRoomDescription:@"" andPoints: 10];
            Item* book_stack_guinea = [[Item alloc] initWithName:@"guinea" andDescription:@"" usedIn:nil andWeight:3 andRoomDescription:@"" andPoints: 10];
            Item* book_stack_iram = [[Item alloc] initWithName:@"iram" andDescription:@"" usedIn:nil andWeight:3 andRoomDescription:@"" andPoints: 10];
            [[library_book_stack hiddenItems] addObject:book_stack_occult];
            [[library_book_stack hiddenItems] addObject:book_stack_guinea];
            [[library_book_stack hiddenItems] addObject:book_stack_iram];
            

        Item* library_fireplace = [[Item alloc] initWithName:@"fireplace" andDescription:@"A brick FIREPLACE.  Three leather-covered chairs face the fireplace. The mantlepiece appears to be ebony.  Carved figures adorn the sides.  The brick and metal are cold, and there is not even the slightest smell of soot in the air.  The cast iron grating covers the front." usedIn:nil andWeight:-1 andRoomDescription:@"Along the north wall of the library there is a FIREPLACE."];
            //Items inside the fireplace
            
    
        //Collectable Items
        Item* bust = [[Item alloc] initWithName:@"bust" andDescription:@"A pale marble bust of some long forgotten Greek god." usedIn:nil andWeight:5 andRoomDescription:@"" andPoints:0 andSpecial:true];
        
        [sitting_room addItem: library_fireplace];
        [sitting_room addItem: library_book_stand];
        [sitting_room addItem: library_book_stack];
        [sitting_room addItem: bust];


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
             Item* lantern = [[Item alloc] initWithName:@"lantern" andDescription:@"A tin lantern.  The metal is more rust than shine, and the glass covering is chipped at the top.  There appears to be a small amount of oil in the reservoir." usedIn:cave andWeight:3 andRoomDescription:@"An old lantern hangs from a peg on the wall."];
            [[srvnt_dining_room_table hiddenItems] addObject: lantern];

        [srvnt_dining_room addItem: srvnt_dining_room_table];

    //Items in the well house
        //Collectable items
        Item* ladder = [[Item alloc] initWithName:@"ladder" andDescription:@"A short wodden ladder.  It appears sturdy enough." usedIn:upstairs_hall andWeight:15 andRoomDescription:@"A wooden LADDER leans against the wall."];
    
        [well_house addItem:ladder];


    //Items in the cave
        //Fixed items
        Item* cave_gleam = [[Item alloc] initWithName:@"gleam" andDescription:@"A small section of the floor gleams a bit brighter than the rest.  Sticking up slightly from the mud you see the outline of something hard.  You scrape the mud away and see that there is a small statue embeded in the ground" usedIn:nil andWeight:-1 andRoomDescription:@""];
            //Items in the gleam
            Item* cthulhu = [[Item alloc] initWithName:@"statue" andDescription:@"A small jade statue of some obscene monstrosity.  It is vaguely huminoid, but bat wings drap the figure, and a mass of tenticles are its mouth.  The figure is crouched, as if waiting.  Along the base there are words carved: \"Ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn.\""usedIn:nil andWeight:3 andRoomDescription:@"" andPoints:0 andSpecial:true];
            [[cave_gleam hiddenItems] addObject:cthulhu];
        
        [cave addItem:cave_gleam];
    
    //Items in the cave tunnel
    
    //Items in the cemetery
        //Fixed items
        Item* grave = [[Item alloc] initWithName:@"grave" andDescription:@"A newly dug grave.  The headstone reads:\n       \"William @#$@\n       1887 - 1918\n   Beloved Husband and Father.\"\nThe ground ground of the grave is disturbed, like some animal has dug into it.  The hole reaches far enough into the ground that the end disappears into darkness.  Strangely, there is only a small amount of dirt above ground.  A small locket glints in the dirt beside the grave." usedIn:nil andWeight:-1 andRoomDescription:@"  At the eastern edge of the plot there is a fresh GRAVE." andPoints:10];
            //Items beside the grave
            Item* locket = [[Item alloc] initWithName:@"locket" andDescription:@"A gold locket.  Inside there is a picture of a smiling man and woman and infant.  On the back, in letters small enough to be hard to read by the moonlight there is an inscription: \"Olphelia, Wife and Mother. With love. W. 1913\"" usedIn:nil andWeight:1 andRoomDescription:@"" andPoints:0 andSpecial:true];
            [[grave hiddenItems] addObject:locket];
        [cemetery addItem:grave];
    
    //Items in the sewing room
        //Fixed items
        Item* sewing_room_corner = [[Item alloc] initWithName:@"corner" andDescription:@"In the corner there is movement EXPAND MOVEMENT TOWARDS MIRROR HERE" usedIn:nil andWeight:-1 andRoomDescription:@""];
            //Items in the corner
   			 Item* mirror = [[Item alloc] initWithName:@"thing" andDescription:@"In the corner of the room some THING waits crouched.  In the dim light it is impossible to make out any details. EXPAND DESCRIPTION OF TOUCHING THE MIRROR" usedIn:nil andWeight:60 andRoomDescription:@"" andPoints:20];
            [[sewing_room_corner hiddenItems] addObject:mirror];
        //Regular Items
        Item* axe = [[Item alloc] initWithName:@"axe" andDescription:@"A broken AXE.  The handle is just long enough to be used as a hatchet." usedIn:hall1 andWeight:1 andRoomDescription:@"Lying beside the body there is a broken AXE."];
    
        [sewing_room addItem:sewing_room_corner];
        [sewing_room addItem:axe];
    
     
    //Some (collectable) Items
    //move these to appropriate rooms once the story is fleshed out.
   
    
    
    
    
    
    
    
     
    
    
    
    
    //In order to advance the sense of amnesia we can start in a (semi) random room.
	NSMutableArray *rooms = [NSArray arrayWithObjects: bed1, workroom, bed3, mast_bed, mast_bath, bathroom, srvnt_bed_room, nil];
  
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
            wrongCommands++;
            if (wrongCommands > 2) {
                [player outputMessage:[NSString stringWithFormat:@"\nI wasn't sure how to %@.\n", commandString]];
                [player outputMessage:@"Sometimes the pain in my head became unbearable and the simplest of tasks became overwhelming.  I remembered that I could ask for 'help' for some tips.\n"];
                [self setWrongCommands: 1];
            } else {
                [player outputMessage:[NSString stringWithFormat:@"\nI couldn't remember how to %@\n", commandString ]];
            }
        }
    }
    return finished;
}

-(NSString *)welcome
{
	return [NSString stringWithFormat:@"I awoke.  The pain in my head was blinding. I looked around and saw that I had been laying in a puddle of mud and water in %@.\nMy clothes, which I did not recognize, appeared to have once been fine, but were now torn, muddy, and soaked.  I couldn't remember how I came to this place.  Perhaps this house holds some answers.\n\nUse your words to control the player, search the house to find a way out, or explore further to unlock hidden mysteries.\nSay 'help' for a complete list of commands.\n", [player currentRoom]];
}

-(NSString *)goodbye
{
    int hiddenItems = 0;
     for (NSString* key in [player inventory])  {
         Item* theItem = [[player inventory] objectForKey:key];
         if ([theItem special]) {
             hiddenItems++;
         }
     }
    
    return [NSString stringWithFormat:@"\nThank you for playing, Goodbye.\n\tHidden Items found: %i\n\tTotal Story uncovered: %i", hiddenItems, [player points]];
}

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitRoom:) name:@"playerWillExitRoom" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterRoom:) name:@"playerDidEnterRoom" object:nil];
}

-(void)willExitRoom:(NSNotification*)notification {
    Player* player = (Player*)[notification object];
    //NSLog(@"The player will exit the room %@", [[player currentRoom] tag]);
    
}

-(void)didEnterRoom:(NSNotification*)notification {
    Room* theRoom = (Room*)[notification object];
    
    //NSLog(@"The player will enter the room %@",[theRoom tag]);
    
    if ([[theRoom tag] isEqualToString:@"the front steps of the house"] ) {
        [self end];
    }
}

-(void)dealloc
{
	[parser release];
	[player release];
	
	[super dealloc];
}

@end
