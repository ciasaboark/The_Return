//
//  TakeCommand.m
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "TakeCommand.h"

@implementation TakeCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"take";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        
        //[player walkTo:secondWord];
	}
	else {
        [player outputMessage:@"\nTake what?"];
	}
	return NO;
}

@end
