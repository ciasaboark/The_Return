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
#import "Item.h"
#import "GameIO.h"


@interface Player : NSObject {
    Room* currentRoom;
    GameIO* io;
    NSMutableDictionary* inventory;
    int maxWeight;
    int currentWeight;
    NSArray* sleepRooms;                //candidate rooms to which the player may wake
    Boolean hasTakenItem;				//whether or not the player has picked anything up yet
    Room* startRoom;					//used for the xyzzy command
    NSMutableArray* roomStack;          //used for the back command
    int points;
}

@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)GameIO *io;
@property (retain, nonatomic)NSMutableDictionary* inventory;
@property (nonatomic)int maxWeight;
@property (nonatomic)int currentWeight;
@property (retain, nonatomic)NSArray* sleepRooms;
@property (nonatomic)Boolean hasTakenItem;
@property (retain, nonatomic)Room* startRoom;
@property (retain, nonatomic)NSMutableArray* roomStack;
@property (nonatomic)int points;

-(id)init;
-(id)initWithRoom:(NSArray *)rooms andIO:(GameIO *)theIO;
-(void)walkTo:(NSString *)direction;
-(void)outputMessage:(NSString *)message;

-(void)addItem:(Item*) anItem;
-(Boolean)hasItem:(NSString*) itemName;
-(Item*)removeItem:(NSString*) itemName;

-(void)addPoints:(int) morePoints;

-(void)pushRoom:(Room*)aRoom;
-(Room*)popRoom;

-(void)dealloc;
@end