//
//  DropCommand.h
//  StarterGame
//
//  Created by Student2 on 3/16/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "Command.h"

@interface DropCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end
