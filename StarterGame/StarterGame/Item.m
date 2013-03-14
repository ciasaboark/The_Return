//Jonathan Nelson

#import "Item.h"
#import "Room.h"

@implementation Item

@synthesize name;
@synthesize description;
@synthesize roomDescription;
@synthesize hiddenItems;
@synthesize usedIn;
@synthesize weight;

-(id)init {
	return [self initWithName:@"Default Item" andDescription:@"Default Description" usedIn:nil];
}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription {
	self = [super init];

	if (self != nil) {
		name = newName;
		description = newDescription;
		usedIn = aRoom;
		weight = aWeight;
		roomDescription = newRoomDescription;
		//the initializer does not handle hidden items.  These are added later.
		hiddenItems = [[NSMutableArray alloc] init];
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