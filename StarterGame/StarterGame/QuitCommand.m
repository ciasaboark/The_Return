//
//  QuitCommand.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "QuitCommand.h"


@implementation QuitCommand

-(id)init
{
	self = [super init];
    
    if (nil != self) {
        name = @"quit";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player
{
	BOOL answer = YES;
	if ([self hasSecondWord]) {
        [player outputMessage:[NSString stringWithFormat:@"\nI cannot quit %@", secondWord]];
		answer = NO;
	}
	return answer;
}

@end
