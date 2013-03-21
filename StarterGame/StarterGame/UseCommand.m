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
                    [[player currentRoom] setExit:@"north" toRoom:[[[player currentRoom] exits] objectForKey:@"hidden"];
                    [[player currentRoom] setLongDescription: @"At the bottom of the well you find yourself in a cave of some sorts.  The light from the lantern illuminates a passageway leading north.  Even with the light it is hards to see any details.  The walls seem to absorb the light, but there is a small gleam from something on the floor."];
                    
                }
                
                else if ([secondWord isEqualToString:@"key"]) {
                    [player outputMessage:@"You leave the key in the lock as you open the door.  The hinges creaks."];
                    [player setCurrentWeight: [player currentWeight] - [tmpItem weight]];
                    [[player inventory] removeObjectForKey:@"key"];
                    [[player currentRoom] setExit:@"south" toRoom:[player endRoom]];
                    [player walkTo:@"south"];
                    
                }
                
                else if ([secondWord isEqualToString:@"axe"]) {
                    [player outputMessage:@"You use the axe on the front door."];
                    [[player currentRoom] setLongDescription: @"The hallway is lit by two small windows flanking the main entrance to the south.  The floor is bare wood, dark in color.  The front door lies in splinters.  To the east there is a dining room.  To the west there is a formal hall.  The hall continues to the north, where you can see additonal rooms."];
                    [[player currentRoom] setExit:@"south" toRoom:[[[player currentRoom] exits] objectForKey:@"hidden"];
                    [player walkTo:@"south"];
                    [player outputMessage:@"The game should end here"];
                    //output some scary text here
                    //calculate the players score
                    //[game end];
                }

                else if ([secondWord isEqualToString:@"ladder"]) {
                    [player outputMessage:@"You place the ladder against the wall underneath the panel.  It should be tall enough to reach the attic."];
                     [player setCurrentWeight: [player currentWeight] - [tmpItem weight]];
                    [[player inventory] removeObjectForKey:@"ladder"];
                    //TODO change the hall description to include the ladder
                    [[player currentRoom] setExit:@"up" toRoom:[[[player currentRoom] exits] objectForKey:@"hidden"]];               
                }

                else {
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

