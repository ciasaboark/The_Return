//
//  LookCommand.h
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Command.h"


@interface LookCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end