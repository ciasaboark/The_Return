//
//  SoundServer.h
//  The Return
//
//  Created by Student2 on 4/1/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Room.h"

@interface SoundServer : NSObject {
}

@property (retain,nonatomic)NSSound* ambient;

+(id)sharedInstance;


@end
