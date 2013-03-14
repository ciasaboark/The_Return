// Jonathan Nelson

#import <Cocoa/Cocoa.h>
#import "Room.h"

@interface Item : NSObject {
	//A one word, unique description of the item.  It is the term that the player must type to 'look', 'take',
	//+ or 'use' this item.  Note that if the item's weight is -1 or > 30, then there can be multiple items with
	//+ the same name within the world, but only one per room.
	NSString* name;

	//A long, free form description of the object.
	NSString* description;

	//A long, free form description of the object as it appears in the room.  If the item is visible, this will be
	//+ appended to the room description when the player uses the 'look' command.  If the item has been 'drop'ed in
	//+ a room this description is not used, and a generic description of 'drop'ed items (the short name) is used
	//+ instead.
	NSString* roomDescription;

	/*
	//Has the player discovered the item yet?  All visible items are listed after the room description, so items that
	//+ are "hidden" within another item should be set to false initially, and changed in the 
	Boolean visible;
	*/

	//This item may have been dropped in a room other than where it was initially placed.
	Boolean isDropped;

	//This item can hold other Items.  These items are "hidden" from the room description until this item is 'look'ed
	//+ at, then they are moved into the current room.
	NSMutableArray* hiddenItems;
	
	//Collectable items may have a use in a specific room.  If no use is intended, this should be nil.
	Room* usedIn;
	
	//Item weight.  The player can hold a total of ~30.  Items that can be collected should have a weight of less
	//+ that that.  Items that are intended to be fixed in a specific room should have a weight greater than
	//+ 30.  Items that have a weight of -1 are considered to be incorporeal or immobile.  This allows Item to describe
	//+ places within a room (corner, window, a locked door) that should not even be attempted to be moved.
	int weight;

}

@property (retain, nonatomic)NSString* name;
@property (retain, nonatomic)NSString* description;
@property (retain, nonatomic)NSString* roomDescription;
@property (retain, nonatomic)NSMutableArray* hiddenItems;
@property (retain, nonatomic)Room* usedIn;
@property (nonatomic)int weight;


-(id)init;
-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom
		andWeight:(int) aWeight andRoomDescription:(NSString*) newRoomDescription;

-(void)addHiddenItem

-(void)dealloc;

@end
