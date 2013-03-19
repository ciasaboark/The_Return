//
//  CommandWords.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "CommandWords.h"
#import "HelpCommand.h"


@implementation CommandWords

-(id)init
{
    return [self initFromList:@"GoCommand QuitCommand LookCommand UseCommand TakeCommand SleepCommand DropCommand InventoryCommand XyzzyCommand"];
}

-(id)initFromList:(NSString *)commandList;
{
	self = [super init];
	if (nil != self) {
        NSArray *words = [commandList componentsSeparatedByString:@" "];
		commands = [[NSMutableDictionary alloc] initWithCapacity:10];
        for(id commandClass in words)
        {
            Command *command = [[[NSClassFromString(commandClass) alloc] init] autorelease];
            if (command) {
                [commands setObject:command forKey:[command name]];
            }
        }
        Command *command = [[[HelpCommand alloc] initWithWords:self] autorelease];
        [commands setObject:command forKey:[command name]];
	}
	return self;
}

-(Command *)get:(NSString *)word
{
	return [commands objectForKey:word];
}

-(NSString *)description
{
	NSArray *words = [commands allKeys];
	return [words componentsJoinedByString:@" "];
}

-(void)dealloc
{
	[commands release];
	
	[super dealloc];
}

@end
