//
//  Room.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Item;

@interface Room : NSObject {
	NSString* tag;
	NSMutableDictionary* exits;
    NSString* longDescription;
    NSMutableDictionary* items;
    NSString* roomType;	//one of: ground, upstairs, attic, cave, outside
    NSString* preferedAmbient;
}

@property (retain, nonatomic)NSString* tag;
@property (retain, nonatomic)NSString* longDescription;
@property (retain, nonatomic)NSMutableDictionary* items;
@property (retain, nonatomic)NSMutableDictionary* exits;
@property (retain, nonatomic)NSString* roomType;
@property (retain, nonatomic)NSString* preferedAmbient;

-(id)init;
-(id)initWithTag:(NSString *)newTag;
-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(BOOL)hasItem:(NSString*)itemName;
-(void)addItem:(Item*)anItem;
-(Item*)getItem:(NSString*)itemName;	//only returns a reference to the item, nill if the item does not exist
-(Item*)removeItem:(NSString*)itemName;
-(Room *)getExit:(NSString *)exit;
// -(NSString *)getExits;

@end
