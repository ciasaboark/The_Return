#import "TakeCommand.h"

@class Item;

@implementation TakeCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"take";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        //check the current room to see if the item exist
        
        Item* itemToTake = [[[player currentRoom] items] objectForKey: secondWord];
        [itemToTake retain];
        if (itemToTake == nil ) {
            //the item is not in the room
            [player outputMessage:@"\nThat items does not exist here\n"];

        } else {
            //the item exists
            if ([itemToTake weight] + [player currentWeight] > [player maxWeight] ) {
                //but the item is too heavy
                [player outputMessage:[NSString stringWithFormat:@"\nI tried to lift the %@, but it did not budge.  Perhaps I was carrying too much.\n", secondWord]];
                 
            } else if ([itemToTake weight] < 0) {
                [player outputMessage:@"\nHow could I take that?\n"];
                 
            
            } else {
                //we can take the item
                [[NSNotificationCenter defaultCenter] postNotificationName:@"playerTookItem" object:nil];
                [[[player currentRoom] items] removeObjectForKey: secondWord];    //remove the item from the room
                [[player inventory] setObject: itemToTake forKey: secondWord];      //and place it in the players inventory
                [itemToTake setIsDropped:false];
                [player setCurrentWeight: [player currentWeight] + [itemToTake weight]];
                
                //give some fancy feedback if this was the first item we picked up
                if ([player hasTakenItem] == false ) {
                    [player outputMessage: [NSString stringWithFormat:@"\nI searched for something to carry the %@ in but find nothing.  My pants, once fine, were torn, and seemed to have been made without pockets.  I took off my coat and, with a little work, fashioned a crude backpack of sorts, hoping that the %@ would remain secure.\n", secondWord, secondWord]];
                    [player setHasTakenItem: true];
                } else {                    
                    [player outputMessage: [NSString stringWithFormat:@"\nI placed the %@ in my backpack.\n", secondWord]];
                }
                
                if ([player maxWeight] - [player currentWeight] < 10) {
                    //the player is close to being over-encumbered
                    [player outputMessage:@"My backpack rested uncomfortably on my back. I wasn't sure how much more I could carry.\n"];
                }
            }
        }
        [itemToTake release];
        
	}
	else {
        [player outputMessage:@"\nTake what?\n"];
	}
	return NO;
}

@end
