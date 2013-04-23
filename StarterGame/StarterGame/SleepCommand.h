#import <Foundation/Foundation.h>
#import "Command.h"

@interface SleepCommand : Command
-(id)init;
-(BOOL)execute:(Player *)player;

@end
