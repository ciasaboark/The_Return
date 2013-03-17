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
//#import "Inventory.h"
#import "Item.h"
#import "GameIO.h"


@interface Player : NSObject {
    Room* currentRoom;
    GameIO* io;
    //Inventory* playerInventory;
    NSMutableDictionary* inventory;
    int maxWeight;
    int currentWeight;
    NSArray* sleepRooms;
}

@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)GameIO *io;
//@property (retain, nonatomic)Inventory* playerInventory;
@property (retain, nonatomic)NSMutableDictionary* inventory;
@property (nonatomic)int maxWeight;
@property (nonatomic)int currentWeight;
@property (retain, nonatomic)NSArray* sleepRooms;

-(id)init;
-(id)initWithRoom:(NSArray *)rooms andIO:(GameIO *)theIO;
-(void)walkTo:(NSString *)direction;
-(void)outputMessage:(NSString *)message;
-(void)addToInventory:(Item*) anItem;

@end
