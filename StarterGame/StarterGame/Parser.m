//
//  Parser.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Parser.h"


@implementation Parser

@synthesize commands;

-(id)init
{
	return [self initWithCommands:[[[CommandWords alloc] init] autorelease]];
}

-(id)initWithCommands:(CommandWords *)newCommands
{
	self = [super init];
    
	if (nil != self) {
		[self setCommands:newCommands];
	}
    
	return self;
}

-(Command *)parseCommand:(NSString *)commandString
{
	NSString *word1 = nil;
	NSString *word2 = nil;
	
	Command *command = nil;
    NSArray *words = [commandString componentsSeparatedByString:@" "];
    if ([words count] > 1) {
        word2 = [words objectAtIndex:1];
    }
    word1 = [words objectAtIndex:0];
    command = [commands get:word1];
    if (command) {
        [command setSecondWord:word2];
    }
	return command;
}

-(NSString *)description
{
	return [commands description];
}

-(void)dealloc
{
	[commands release];
	
	[super dealloc];
}

@end
