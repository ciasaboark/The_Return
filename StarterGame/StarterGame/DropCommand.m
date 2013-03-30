#import "DropCommand.h"

@implementation DropCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"drop";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        //check the current room to see if the item exist
        
        Item* itemToDrop = [[player inventory] objectForKey: secondWord];
		[itemToDrop retain];
        
        if (itemToDrop == nil ) {
            //the item is not in the room
            [player outputMessage:@"\nI didn't have that item\n"];
            
        } else {
            [itemToDrop setIsDropped:true];
            
            //lighten the load a bit
            [player setCurrentWeight: [player currentWeight] - [itemToDrop weight]];
            
            //remove item from player
            [[player inventory] removeObjectForKey:[itemToDrop name]];
            
            //add item to the current room
            [[[player currentRoom] items] setObject: itemToDrop forKey: [itemToDrop name]];
            
            [player outputMessage:[NSString stringWithFormat:@"\nI dropped the %@ in the middle of the %@.\n", [itemToDrop name], [[player currentRoom] tag]]];
        }

        [itemToDrop release];
	}
	else {
        [player outputMessage:@"\nDrop what?\n"];
	}
	return NO;
}

@end
