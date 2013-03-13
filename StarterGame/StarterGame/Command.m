//
//  Command.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Command.h"


@implementation Command

@synthesize name;
@synthesize secondWord;

-(id)init
{
	self = [super init];
	if (nil != self) {
        name = @"";
		secondWord = nil;
	}
	return self;
}

-(BOOL)hasSecondWord
{
	return (secondWord != nil);
}

-(BOOL)execute:(Player *)player
{
	return NO;
}

-(void)dealloc
{
	[secondWord release];
	
	[super dealloc];
}

@end
