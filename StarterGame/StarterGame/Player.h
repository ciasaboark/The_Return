//
//  Player.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import <Cocoa/Cocoa.h>
#import "Room.h"
#import "Inventory.h"
//#import "Item.h"
#import "GameIO.h"


@interface Player : NSObject {
    Room* currentRoom;
    GameIO* io;
    Inventory* playerInventory;
}

@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)GameIO *io;
@property (retain, nonatomic)Inventory* playerInventory;

-(id)init;
-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO;
-(void)walkTo:(NSString *)direction;
-(void)outputMessage:(NSString *)message;

@end
