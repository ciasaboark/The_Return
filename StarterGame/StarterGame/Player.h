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
    unsigned int maxWeight;
    unsigned int currentWeight;
    NSArray* sleepRooms;                //candidate rooms to which the player may wake
    Boolean hasTakenItem;				//whether or not the player has picked anything up yet
    Room* startRoom;					//used for the xyzzy command
    NSMutableArray* roomStack;          //used for the back command
    
    //points and flags are based on item points, and are assigned when the player
    //+ 'look's at an item. The item points are either 0 or a unique power of 2.

    //the sum of the filtered points from each item the player has looked at.
    //+ The filter should reduce the range from 2 to ~26 points per item.
    int points;

    //the sum of all the points of items the player has looked at. This will be used to create
    //+ a mask so that we can later check which items the player has discovered.
    int flags;
}

@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)GameIO *io;
@property (retain, nonatomic)NSMutableDictionary* inventory;
@property (nonatomic)unsigned int maxWeight;
@property (nonatomic)unsigned int currentWeight;
@property (retain, nonatomic)NSArray* sleepRooms;
@property (nonatomic)Boolean hasTakenItem;
@property (retain, nonatomic)Room* startRoom;
@property (retain, nonatomic)NSMutableArray* roomStack;
@property (nonatomic)int points;
@property (nonatomic)int flags;

-(id)init;
-(id)initWithRoom:(NSArray *)rooms andIO:(GameIO *)theIO;
-(void)walkTo:(NSString *)direction;
-(void)outputMessage:(NSString *)message;

-(void)addItem:(Item*) anItem;
-(BOOL)hasItem:(NSString*) itemName;
-(Item*)getItem:(NSString*)itemName;    //does not modify inventory, returns nil for non existant item
-(Item*)removeItem:(NSString*) itemName;
-(unsigned long)invSize;

//every clue for the backstory has a unique prime number assigned, those points are used to calculate
//+ a score, and can be passed to hasViewed() to see if the player has viewed that clue
-(void)addPoints:(int) morePoints;
-(BOOL)hasViewed:(int) storyCode;

-(void)pushRoom:(Room*)aRoom;
-(Room*)popRoom;
-(void)clearRoomStack;

-(void)dealloc;
@end