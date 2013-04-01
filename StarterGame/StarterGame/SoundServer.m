//
//  SoundServer.m
//  The Return
//
//  Created by Student2 on 4/1/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "SoundServer.h"


@implementation SoundServer

@synthesize ambient;

static NSSound* ambient;

+(id)sharedInstance {
    static SoundServer* sndServer = nil;
    if (!sndServer) {
        NSLog(@"sound server: started\n");
        sndServer = [[[self class] alloc] init];
        ambient = nil;
        [self registerForNotifications];
    } else {
        NSLog(@"sound server already running\n");
    }
    return sndServer;
}

+(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStarted) name:@"gameStarted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathBlocked) name:@"pathBlocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathLocked) name:@"pathLocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathUnlocked) name:@"pathUnlocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathDark) name:@"pathDark" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transitionRoom) name:@"transitionRoom" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transitionStairs) name:@"transitionStairs" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(envInside) name:@"envInside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(envOutside) name:@"envOutside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(envCave) name:@"envCave" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterRoom:) name:@"playerDidEnterRoom" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUsedItem:) name:@"playerUsedItem" object:nil];
}

+(void)gameStarted {
    NSLog(@"sound server: game started\n");
    //how about some moody music
    NSSound* sound = [NSSound soundNamed:@"dark.mp3"];
    [sound retain];
    [sound setLoops: YES];
    [sound setVolume:.2];
    [sound play];
}

+(void)didEnterRoom:(NSNotification*)notification {
    Room* theRoom = (Room*)[notification object];
    NSLog(@"sound server: player changed room\n");
    
    if ([[theRoom tag] isEqualToString:@"a small family cemetery"] ) {
        NSLog(@"sound server: player outside\n");
        [self stopAmbientSound];
        [self envOutside];
    } else if ([[theRoom tag] isEqualToString:@"an underground cave"] || [[theRoom tag] isEqualToString:@"a long underground tunnel"]) {
        NSLog(@"sound server: player in cave\n");
        [self stopAmbientSound];
        [self envCave];
    } else {
        [self stopAmbientSound];
        [self envInside];
    }
}

+(void)stopAmbientSound {
    if (ambient) {
        NSLog(@"Ambient sound was still playing");
        
        struct timespec ts;
    	ts.tv_sec = 0;
    	ts.tv_nsec = 1000000;
        
        for (int i = 1; i < 100; i++) {
            [ambient setVolume: (1.0 / i)];
            //nanosleep(&ts, &ts);
            usleep(10000);
        }
        
        [ambient stop];
        [ambient release];
        ambient = nil;
    }
}

+(void)playerUsedItem:(NSNotification*) notification {
    NSLog(@"sound server: player used item");
    
    NSString* itemName = (NSString*)[notification object];
    
    if ([itemName isEqualToString:@"lantern"]) {
        NSSound* sound = [NSSound soundNamed:@"match.mp3"];
        [sound retain];
        [sound setLoops: NO];
        [sound setVolume:1.0];
        [sound play];
        [sound release];
    } else if ([itemName isEqualToString:@"axe"]) {
        //chopping sounds here
    } else if ([itemName isEqualToString:@"key"]) {
        NSSound* sound = [NSSound soundNamed:@"unlock.mp3"];
        [sound retain];
        [sound setLoops: NO];
        [sound setVolume:1.0];
        [sound play];
        [sound release];
    }  else if ([itemName isEqualToString:@"coal"]) {
        NSSound* sound = [NSSound soundNamed:@"coal.mp3"];
        [sound retain];
        [sound setLoops: NO];
        [sound setVolume:1.0];
        [sound play];
        [sound release];
    }
}

+(void)pathBlocked {
   NSLog(@"sound server: path blocked\n");
}


+(void)pathLocked {
    NSLog(@"sound server: path locked\n");
}

+(void)pathUnlocked {
    NSLog(@"sound server: path unlocked\n");
    
    NSSound* sound = [NSSound soundNamed:@"creak.mp3"];
    [sound retain];
    [sound setLoops: NO];
    [sound setVolume:.9];
    [sound play];
    [sound release];
}

+(void)pathDark {
    NSLog(@"sound server: path dark\n");
}

+(void)transitonRoom {
    NSLog(@"sound server: transition room\n");
}

+(void)transitionStairs {
    NSLog(@"sound server: transition stairs\n");
}

+(void)envInside {
    NSLog(@"sound server: environment inside\n");
}

+(void)envOutside {
    NSLog(@"sound server: environment outside\n");
    ambient = [NSSound soundNamed:@"wind.mp3"];
    [ambient retain];
    [ambient setLoops: YES];
    [ambient setVolume:.7];
    [ambient play];
}

+(void)envCave {
    NSLog(@"sound server: environment cave\n");
    ambient = [NSSound soundNamed:@"cave"];
    [ambient retain];
    [ambient setLoops: YES];
    [ambient setVolume:.7];
    [ambient play];
}



@end
