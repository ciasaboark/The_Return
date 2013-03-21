//
//  XyzzyCommand.m
//  StarterGame
//
//  Created by Student2 on 3/20/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "XyzzyCommand.h"

@implementation XyzzyCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"xyzzy";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player setCurrentRoom: [player startRoom]];
    [[player roomStack] removeAllObjects];
    [player outputMessage:[NSString stringWithFormat:@"As you step forward your vision fades, and find yourself back in %@", [player startRoom]]];
    
	return NO;
}

@end