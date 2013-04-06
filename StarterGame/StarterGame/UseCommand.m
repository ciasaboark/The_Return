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
        Item* tmpItem = [player getItem: secondWord];

        if (tmpItem != nil) {
            //check that we are in the correct room to use this item
            if ([tmpItem usedIn] == [player currentRoom]) {
                
                //Send a notification to the sound server so we can do some awesome audio stuff
                [[NSNotificationCenter defaultCenter] postNotificationName:@"playerUsedItem" object:secondWord];
                
                // match against known items
                //there doesn't seem to be a way to switch using NSStrings so get ready for some if/elses
                if ([secondWord isEqualToString:@"lantern"]) {
                    [player removeItem: @"lantern"];
                    [player outputMessage:@"\nAfter some fumbling in the dark I managed to light the lantern. The darkness fled. I noticed a spike driven into the wall, and hung the lantern there. The glow stretched outwards, illuminating a passageway to the north.\n"];
                    [[player currentRoom] setExit:@"north" toRoom:[[player currentRoom] getExit:@"hidden"]];
                    [[[player currentRoom] exits] removeObjectForKey:@"south"];
                    [[[player currentRoom] exits] removeObjectForKey:@"east"];
                    [[[player currentRoom] exits] removeObjectForKey:@"west"];
                    [[[player currentRoom] exits] removeObjectForKey:@"down"];
                             
                    [[player currentRoom] setLongDescription: @"At the bottom of the well I found myself in a cave of some sorts. The light from the lantern illuminated a passageway leading north. The rope from the well ended a foot above the floor."];
                }
                
                else if ([secondWord isEqualToString:@"key"]) {
                    [player outputMessage:@"\nI left the key in the lock as I opened the door. The hinges creaked as the door swung inward.\n"];
                    [[player currentRoom] setLongDescription:@"The hall ran south from the stairway. A door to the east led to a child's bedroom, a door to the west led to another bedroom. Light from both rooms flooded the northern end of the hall in light, but the southern end was wreathed in shadow. The door at the southern end was now open. A small panel overhead looked like it might lead to an attic.\n"];
                    [player removeItem: @"key"];
                    [[player currentRoom] setExit:@"south" toRoom:[[player currentRoom] getExit:@"end"]];
                }
                
                else if ([secondWord isEqualToString:@"axe"]) {
                    [player outputMessage:@"\nI used the axe on the front door. Splinters flew. The way out was clear.\n"];
                    [[player currentRoom] setLongDescription: @"The hallway was lit by two small windows flanking the main entrance to the south. The floor was bare wood, dark in color. The front door to the south lied in splinters. To the east there was a dining room. To the west there was a formal hall. The hall continued to the north, where I could see additonal rooms."];
                    [[player currentRoom] setExit:@"south" toRoom:[[player currentRoom] getExit:@"hidden"]];
                }

                else if ([secondWord isEqualToString:@"ladder"]) {
                    [player outputMessage:@"\nI placed the ladder against the wall underneath the panel. It looked tall enough to reach the attic panel.\n"];
                    [player removeItem: @"ladder"];
                    //TODO change the hall description to include the ladder
                    [[player currentRoom] setExit:@"up" toRoom:[[player currentRoom] getExit:@"hidden"]];
                }

                else if ([secondWord isEqualToString:@"coal"]) {
                    [player outputMessage:@"\nI picked a small piece of coal out of the box and dropped it into the well opening. After a short delay I heard the distinct sound of rock hitting rock. I couldn't tell how deep the well was, but it shaft definately didn't end in water.\n"];
                }

                else {
                    [player outputMessage:@"\nWoops, this item is missing its use block\n"];
                }
            } else {
                [player outputMessage:[NSString stringWithFormat:@"I couldn't see how to use the %@ here.\n",secondWord]];
            }
        } else {
            [player outputMessage:@"I did not have that item.\n"];
        }
    } else {
        [player outputMessage:@"Use what?\n"];
    }
    return NO;
}

@end

