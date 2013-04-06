//
//  Room.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import "Room.h"
#import "Item.h"


@implementation Room

@synthesize tag;
@synthesize longDescription;
@synthesize items;
@synthesize exits;
@synthesize type;

-(id)init
{
	return [self initWithTag:@"No Tag"];
}

-(id)initWithTag:(NSString *)newTag
{
	self = [super init];
    
	if (nil != self) {
		[self setTag:newTag];
        //to keep the code readable init only touches the short description  Game->CreateWorld
        //+ will update the long descriptions after the rooms are created.
        [self setLongDescription:nil]; 
		
        exits = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        //items are added after initialization
        items = [[NSMutableDictionary alloc] init];

        //type is set to ground floor by default
        type = 0;
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

-(BOOL)hasItem:(NSString*)itemName {
	BOOL response = NO;
	if ([[self items] objectForKey: itemName] != nil) {
		response = YES;
	}

	return response;
}

-(void)addItem:(Item*)anItem {
    if (anItem != nil) {
        [items setObject: anItem forKey: [anItem name]];
    }
}

-(Item*)getItem:(NSString*)itemName {
    Item* theItem = [items objectForKey: itemName];
    [theItem retain];
    return [theItem autorelease];
}


-(Item*)removeItem:(NSString*)itemName {
	Item* theItem = [[self items] objectForKey: itemName];
	[theItem retain];
	[items removeObjectForKey: itemName];

	return [theItem autorelease];
}

// -(NSString *)getExits
// {
// 	NSArray *exitNames = [exits allKeys];
// 	return [NSString stringWithFormat:@"Exits: %@", [exitNames componentsJoinedByString:@" "]];
// }


-(NSString *)description {
    return tag;
}

-(void)dealloc {
	[tag release];
	[exits release];
    [longDescription release];
    [items release];

	[super dealloc];
}

@end
