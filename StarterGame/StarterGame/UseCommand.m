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
                    [player outputMessage:@"\nAfter some fumbling in the dark I managed to light the lantern. The darkness fled. I noticed a spike driven into the wall, and hung the lantern there. The glow stretched outwards, illuminating a passageway to the north."];
                    [[player currentRoom] setExit:@"north" toRoom:[[player currentRoom] getExit:@"hidden"]];
                    [[player currentRoom] setLongDescription: @"At the bottom of the well I found myself in a cave of some sorts. The light from the lantern illuminated a passageway leading north. The rope from the well ended a foot above the floor."];
                }
                
                else if ([secondWord isEqualToString:@"key"]) {
                    [player outputMessage:@"\nI left the key in the lock as I opened the door.  The hinges creaked as the door swung inward."];
                    [[player currentRoom] setLongDescription:@"The hall ran south from the stairway. A door to the east led to a child's bedroom, a door to the west led to another bedroom. Light from both rooms flooded the northern end of the hall in light, but the southern end was wreathed in shadow. The door at the southern end was now open. A small panel overhead looked like it might lead to an attic."];
                    [player setCurrentWeight: [player currentWeight] - [tmpItem weight]];
                    [[player inventory] removeObjectForKey:@"key"];
                    [[player currentRoom] setExit:@"south" toRoom:[[player currentRoom] getExit:@"end"]];
                    [[player currentRoom] setLongDescription:@""];                    
                }
                
                else if ([secondWord isEqualToString:@"axe"]) {
                    [player outputMessage:@"\nI used the axe on the front door.  Splinters flew.  The way out was clear."];
                    [[player currentRoom] setLongDescription: @"The hallway was lit by two small windows flanking the main entrance to the south. The floor was bare wood, dark in color. The front door to the south lied in splinters. To the east there was a dining room.  To the west there was a formal hall.  The hall continued to the north, where i could see additonal rooms."];
                    [[player currentRoom] setExit:@"south" toRoom:[[player currentRoom] getExit:@"hidden"]];
                }

                else if ([secondWord isEqualToString:@"ladder"]) {
                    [player outputMessage:@"\nI placed the ladder against the wall underneath the panel.  It looked tall enough to reach the attic panel."];
                    [player setCurrentWeight: [player currentWeight] - [tmpItem weight]];
                    [[player inventory] removeObjectForKey:@"ladder"];
                    //TODO change the hall description to include the ladder
                    [[player currentRoom] setExit:@"up" toRoom:[[player currentRoom] getExit:@"hidden"]];
                }

                else {
                    [player outputMessage:@"\nWoops, this item is missing its use block"];
                }
            } else {
                [player outputMessage:[NSString stringWithFormat:@"I couldn't see how to use the %@ here.",secondWord]];
            }
        } else {
            [player outputMessage:@"I did not have that item."];
        }
    } else {
        [player outputMessage:@"Use what?"];
    }
    return NO;
}

@end

