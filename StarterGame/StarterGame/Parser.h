//
//  Parser.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommandWords.h"


@interface Parser : NSObject {
	CommandWords *commands;
}

@property (retain, nonatomic)CommandWords *commands;

-(id)init;
-(id)initWithCommands:(CommandWords *)newCommands;
-(Command *)parseCommand:(NSString *)commandString;

@end
