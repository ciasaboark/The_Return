//
//  CommandWords.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import <Cocoa/Cocoa.h>
#import "Command.h"


@interface CommandWords : NSObject {
	NSMutableDictionary *commands;
}

-(id)init;
-(id)initFromList:(NSString *)commandList;
-(Command *)get:(NSString *)word;

@end
