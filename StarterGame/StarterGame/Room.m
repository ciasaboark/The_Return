//
//  Room.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import "Room.h"


@implementation Room

@synthesize tag;

-(id)init
{
	return [self initWithTag:@"No Tag"];
}

-(id)initWithTag:(NSString *)newTag
{
	self = [super init];
    
	if (nil != self) {
		[self setTag:newTag];
		exits = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
    
	return self;
}

-(void)setExit:(NSString *)exit toRoom:(Room *)room
{
	[exits setObject:room forKey:exit];
}

-(Room *)getExit:(NSString *)exit
{
	return [exits objectForKey:exit];
}

-(NSString *)getExits
{
	NSArray *exitNames = [exits allKeys];
	return [NSString stringWithFormat:@"Exits: %@", [exitNames componentsJoinedByString:@" "]];
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"You are %@.\n *** %@", tag, [self getExits]];
}

-(void)dealloc
{
	[tag release];
	[exits release];
	
	[super dealloc];
}

@end
