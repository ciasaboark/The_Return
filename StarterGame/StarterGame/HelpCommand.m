//
//  HelpCommand.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "HelpCommand.h"


@implementation HelpCommand

@synthesize words;

-(id)init
{
	return [self initWithWords:[[[CommandWords alloc] init] autorelease]];
}

-(id)initWithWords:(CommandWords *)newWords
{
	self = [super init];
    
	if (nil != self) {
		[self setWords:newWords];
        name = @"help";
	}
    
	return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        [player outputMessage:[NSString stringWithFormat:@"\nI can't help you with %@", [self secondWord]]];
    }
    else {
        [player outputMessage:[NSString stringWithFormat:@"\nYou are lost. You are alone. You wander\naround the university.\n\nYour available commands are:\n%@", [words description]  ]];
    }
	return NO;
}

-(void)dealloc
{
	[words release];
	
	[super dealloc];
}

@end
