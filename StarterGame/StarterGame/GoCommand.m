//
//  GoCommand.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "GoCommand.h"


@implementation GoCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"go";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        [player walkTo:secondWord];
	}
	else {
        [player outputMessage:@"\nGo where?"];
	}
	return NO;
}

@end
