//
//  InventoryCommand.h
//  StarterGame
//
//  Created by csu on 3/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "Command.h"

@interface InventoryCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end
