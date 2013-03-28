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

-(id)init {
	return [self initWithName:@"Default Item" andDescription:@"Default Description" usedIn:nil andWeight:-1 andRoomDescription:@"Default Room Description"];
}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
	andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription {
    return [self initWithName:newName andDescription:newDescription usedIn:aRoom andWeight:aWeight andRoomDescription:newRoomDescription andPoints:0 andSpecial:false];
}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
	andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription andPoints:(int)itemPoints {
    return [self initWithName:newName andDescription:newDescription usedIn:aRoom andWeight:aWeight andRoomDescription:newRoomDescription andPoints:0 andSpecial:false];
}


-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
	andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription andPoints:(int)itemPoints
	andSpecial:(Boolean) isSpecial {
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
	}

	return self;
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