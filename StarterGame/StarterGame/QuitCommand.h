//
//  QuitCommand.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Command.h"


@interface QuitCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end
