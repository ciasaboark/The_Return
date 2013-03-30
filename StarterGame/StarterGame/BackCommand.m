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
    Room* backRoom = [player popRoom];
    [backRoom retain];
    
    if (backRoom) {
        [player setCurrentRoom: backRoom];
        [player outputMessage:[NSString stringWithFormat:@"\nI traced my steps back to the %@.\n", backRoom]];
        [backRoom release];
    } else {
        [player outputMessage:@"\nThere was no path back.  There was only forwards.\n"];
    }
    
	return NO;
}
@end
