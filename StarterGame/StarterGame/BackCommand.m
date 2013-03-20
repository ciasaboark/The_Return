//
//  BackCommand.m
//  StarterGame
//
//  Created by Student2 on 3/20/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "BackCommand.h"

@implementation BackCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"back";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    Room* backRoom = [[player roomStack] lastObject];
    
    if (backRoom) {
        [backRoom retain];
        [[player roomStack] removeLastObject];
        [player setCurrentRoom: backRoom];
        [player outputMessage:[NSString stringWithFormat:@"You trace your steps back to the %@.", backRoom]];
        [backRoom release];
    } else {
        [player outputMessage:@"There is no path back.  There is only forwards."];
    }
    
	return NO;
}
@end
