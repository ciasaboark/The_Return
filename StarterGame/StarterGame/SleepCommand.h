//
//  TakeCommand.h
//  StarterGame
//
//  Created by Student1 on 3/13/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface SleepCommand : Command
-(id)init;
-(BOOL)execute:(Player *)player;

@end
