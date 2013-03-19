#import "SleepCommand.h"

@class Item;

@implementation SleepCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"sleep";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	// if ([self hasSecondWord]) {
        
	// }
	// else {
        //TODO: make sure the new room is not the same as the old room
        [player outputMessage:@"\nAn unbearable weight seems to settle on you.  Alone and confused you sink to the floor in a stupor.\n"];
        
        uint32_t rand = arc4random_uniform([[player sleepRooms] count]);

        [player setCurrentRoom: [[player sleepRooms] objectAtIndex: rand]];
        [player outputMessage:[NSString stringWithFormat:@"After some time you wake, and find yourself in %@.  You can't remember how you got here.  Were you moved?", [player currentRoom]]];
    // }
	return NO;
}

@end
