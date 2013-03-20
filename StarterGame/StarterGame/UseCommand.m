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
                if ([secondWord isEqualToString:@"lantern"]) {
                    [player outputMessage:@"You use the lantern"];
                    [[player currentRoom] setLongDescription: @"At the bottom of the well you find yourself in a cave of some sorts.  The light from the lantern illuminates a passageway leading north.  Even with the light it is hards to see any details.  The walls seem to absorb the light, but there is a small gleam from something on the floor."];
                    
                }
                
                else if ([secondWord isEqualToString:@"key"]) {
                    [player outputMessage:@"You use the key to open the door.  The door creaks."];
                    [[player currentRoom] setExit:@"south" toRoom:[player endRoom]];
                    [player walkTo:@"south"];
                    
                }
                
                else if ([secondWord isEqualToString:@"axe"]) {
                    [player outputMessage:@"You use the axe on the front door."];
                    //output some scary text here
                    //[game end];
                } else {
                    [player outputMessage:@"Woops, this item is missing its use block"];
                }
            } else {
                [player outputMessage:@"How would you use that here?"];
            }
        } else {
            [player outputMessage:@"You do not have that item"];
        }
    } else {
        [player outputMessage:@"Use what?"];
    }
    return NO;
}

@end

