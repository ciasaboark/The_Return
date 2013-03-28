//
//  Room.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "Item.h"

@class Item;

@interface Room : NSObject {
	NSString* tag;
	NSMutableDictionary* exits;
    NSString* longDescription;
    NSMutableDictionary* items;
}

@property (retain, nonatomic)NSString* tag;
@property (retain, nonatomic)NSString* longDescription;
@property (retain, nonatomic)NSMutableDictionary* items;

-(id)init;
-(id)initWithTag:(NSString *)newTag;
-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(void)addItem:(Item*) anItem;
-(Room *)getExit:(NSString *)exit;
-(NSString *)getExits;

@end
