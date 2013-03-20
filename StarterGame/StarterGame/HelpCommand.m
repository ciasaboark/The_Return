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
    [player outputMessage:@"\nYou can't remember how you got here.  This house may hold some answers and a way out.\nTo navigate around say: 'go <direction>'.\nYou can retrace your steps by saying: 'back'.\nTo look at the room or an item say 'look' or 'look <item>'.\nIf an item is UPPERCASE then it may be of some intrest, try looking at it.\nTo take an item with you say: 'take <item>'.\nSome items may be of use, say 'use <item>' to see if it can be of use where you are.\nItems have a weight, so you will have to be selective in what you take.\nTo view your burden say: 'inventory'.\nIf the burden of exploration becomes too much to bear you can say 'sleep'.\n"];

	return NO;
}

-(void)dealloc
{
	[words release];
	
	[super dealloc];
}

@end
