//
//  Room.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Room : NSObject {
	NSMutableDictionary *exits;
    NSString* longDescription;
    NSMutableArray* items;
}

@property (retain, nonatomic)NSString* tag;
@property (retain, nonatomic)NSString* longDescription;
@property (retain, nonatomic)NSMutableArray* items;

-(id)init;
-(id)initWithTag:(NSString *)newTag;
-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(Room *)getExit:(NSString *)exit;
-(NSString *)getExits;

@end
