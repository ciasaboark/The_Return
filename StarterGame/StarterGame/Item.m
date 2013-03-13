//Jonathan Nelson

#import "Item.h"
#import "Room.h"

@implementation Item

@synthesize name;
@synthesize description;
@synthesize usedIn;

-(id)init {
	return [self initWithName:@"Default Item" andDescription:@"Default Description" usedIn:nil];
}

-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom {
	self = [super init];

	if (self != nil) {
		name = newName;
		description = newDescription;
		usedIn = aRoom;
	}

	return self;
}

-(void)dealloc {
	[name release];
	[description release];
	[usedIn release];

	[super dealloc];
}

@end