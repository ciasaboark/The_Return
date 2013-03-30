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
    [player outputMessage:@"\nAn unbearable weight seemed to settle on me.  Alone and confused I sunk to the floor in a stupor...\n"];
    unsigned long rand;
    Room* wakeRoom;
    
    //if the player doesn't even know how he got to this room how could he go back?
    [player clearRoomStack];
    
    //we don't want to wake to the same room
    //rand = arc4random_uniform([[player sleepRooms] count]);
    rand = arc4random() % [[player sleepRooms] count];
    wakeRoom = [[player sleepRooms] objectAtIndex:rand];
    
    while ( [[[player currentRoom] tag] isEqualToString:[wakeRoom tag]] ) {
        //rand = arc4random_uniform([[player sleepRooms] count]);
        rand = arc4random() % [[player sleepRooms] count];
        wakeRoom = [[player sleepRooms] objectAtIndex:rand];
    }
    
    [player setCurrentRoom: wakeRoom];
    
   [player outputMessage:[NSString stringWithFormat:@"After some time I awoke, and found myself in %@. I couldn't recall how I got here. Was I moved in my sleep?\n", [player currentRoom]]];
  
	return NO;
}

@end
