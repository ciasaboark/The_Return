//Jonathan Nelson

#import "Item.h"
#import "Room.h"

@implementation Item

@synthesize name;
@synthesize description;
@synthesize roomDescription;
@synthesize isDropped;
@synthesize hiddenItems;
@synthesize usedIn;
@synthesize weight;
@synthesize points;
@synthesize special;
@synthesize visibleWhenPointsEqual;

-(id)init {
	fprintf(stderr, "Item:init called with no arguments, this is likely a bug\n");
	return [self initWithName:@"Default Item" andDescription:@"Default Description" usedIn:nil andWeight:-1 andRoomDescription:@"Default Room Description"];
}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
	andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription {
    return [self initWithName:newName andDescription:newDescription usedIn:aRoom andWeight:aWeight andRoomDescription:newRoomDescription andPoints:0];
}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
	andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription andPoints:(int)itemPoints {
    return [self initWithName:newName andDescription:newDescription usedIn:aRoom andWeight:aWeight andRoomDescription:newRoomDescription andPoints:itemPoints andSpecial:false];
}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
	andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription andPoints:(int)itemPoints
	andSpecial:(Boolean) isSpecial {
    return [self initWithName:newName andDescription:newDescription usedIn:aRoom andWeight:aWeight andRoomDescription:newRoomDescription andPoints:itemPoints andSpecial:isSpecial visibleAfterPointsEqual:0];

}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
	andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription andPoints:(int)itemPoints
	andSpecial:(Boolean) isSpecial visibleAfterPointsEqual:(unsigned int)visiblePoints {
	self = [super init];

	if (self != nil) {
		[self setName: newName];
		[self setDescription: newDescription];
		[self setUsedIn: aRoom];
		[self setWeight: aWeight];
		[self setRoomDescription: newRoomDescription];
		[self setHiddenItems: [[NSMutableArray alloc] init]];
		[self setIsDropped: false];
        [self setPoints: itemPoints];
        [self setSpecial: isSpecial];
        [self setVisibleWhenPointsEqual:visiblePoints];
	}

	return self;
}

-(void)addHiddenItem:(Item*)theItem {
	if (theItem) {
		[[self hiddenItems] addObject: theItem];
	}
}


-(void)removeHiddenItem:(Item*)anItem {
	if (anItem) {
		[[self hiddenItems] removeObject: anItem];
	}
}


-(void)dealloc {
	[name release];
	[description release];
	[usedIn release];
	[roomDescription release];
	[hiddenItems release];

	[super dealloc];
}

@end