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

-(void)addItem:(Item*) anItem {
    if (anItem != nil) {
        [items setObject: anItem forKey: [anItem name]];
    }
}

-(Item*)takeItem:(NSString*) anItemName {
    id anItem = [items objectForKey: anItemName];
    [items removeObjectForKey: anItemName];
    
    return anItem; //anItem could be nil here, must check in TakeCommand
}

-(NSString *)getExits
{
	NSArray *exitNames = [exits allKeys];
	return [NSString stringWithFormat:@"Exits: %@", [exitNames componentsJoinedByString:@" "]];
}

-(NSString *)description
{
	//The exits were originally listed after the short description.  They should be listed within the text of
    //+ the long description instead.
    return [NSString stringWithFormat:@"%@", tag /*, [self getExits]*/];
}

-(void)dealloc
{
	[tag release];
	[exits release];
    [longDescription release];
    [items release];

	[super dealloc];
}

@end
