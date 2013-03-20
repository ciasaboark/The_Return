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
    [player outputMessage:@"\nAn unbearable weight seems to settle on you.  Alone and confused you sink to the floor in a stupor...\n"];
    unsigned long rand;
    Room* wakeRoom;
    
    //we don't want to wake to the same room
    do {
        rand = arc4random_uniform([[player sleepRooms] count] - 1);
        wakeRoom = [[player sleepRooms] objectAtIndex:rand];
        [player setCurrentRoom: wakeRoom];
    } while (![[[player currentRoom] tag] isEqualToString:[wakeRoom tag]]);
    
   [player outputMessage:[NSString stringWithFormat:@"After some time you wake, and find yourself in %@.  You can't remember how you got here.  Were you moved?", [player currentRoom]]];
  
	return NO;
}

@end
