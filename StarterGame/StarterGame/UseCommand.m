#import "UseCommand.h"

@implementation UseCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"use";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        //check that the item is in the inventory
        Item* tmpItem = [[player inventory] objectForKey:secondWord];
        if (tmpItem != nil) {
            //check that we are in the correct room to use this item
            if ([tmpItem usedIn] == [player currentRoom]) {
                
                // match against known items
                //there doesn't seem to be a way to switch/case using NSStrings so get ready for some if/elses
                if (secondWord == @"lantern") {
                    [player outputMessage:@"You use the lantern"];
                }
                
                else if (secondWord == @"key") {
                    [player outputMessage:@"You use the key to open the door.  The door creaks."]
                    [[player currentRoom] setExit:@"south" toRoom:[player endRoom]];
                    [player walkTo:@"south"];
                    
                }
                
                else if (secondWord == @"axe") {
                    [player outputMessage:@"You use the axe on the front door."];
                    //output some scary text here
                    [game end];

                }
            }
        } else {
            [player outputMessage:[NSString stringWithFormat:@"You do not have a %@", secondWord]];
        }
    } else {
        [player outputMessage:@"\nUse what?"];
	}
	return NO;
}
@end
