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
		[self setWords:newWords];	//we won't be 
        name = @"help";
	}
    
	return self;
}

-(BOOL)execute:(Player *)player
{
    [player outputMessage:@"\nYou can't remember how you got here.  This house may hold some answers and a way out.\nTo navigate around say: 'go <direction>'.\nYou can retrace your steps by saying: 'back'.\nTo look at the room or an item say 'look' or 'look <item>'.\nItems of intrest are sometimes UPPERCASE, try looking at them.\nTo take an item with you say: 'take <item>'.\nItems have weight, so you will have to be selective in what you take.\nTo view your burden say: 'inventory'.\nTo lighten your load you can 'drop <item>'.\nSome items may be of use, say 'use <item>' to see if it can be of use where you are.\nIf the burden of exploration becomes too much to bear you can 'sleep' or 'quit'.\n"];

	return NO;
}

-(void)dealloc
{
	[words release];
	
	[super dealloc];
}

@end
