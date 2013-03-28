//
//  HelpCommand.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import <Cocoa/Cocoa.h>
#import "CommandWords.h"


@interface HelpCommand : Command

@property (retain, nonatomic)CommandWords *words;

-(id)init;
-(id)initWithWords:(CommandWords *)newWords;

@end
