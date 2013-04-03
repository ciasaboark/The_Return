//
//  SoundServer.m
//  The Return

#import "SoundServer.h"


@implementation SoundServer

@synthesize ambient;

static NSSound* ambient;
static bool inTransition;

+(id)sharedInstance {
    static SoundServer* sndServer = nil;
    if (!sndServer) {
        sndServer = [[[self class] alloc] init];
        ambient = nil;
        inTransition = false;
        [self registerForNotifications];
    } else {
        NSLog(@"SoundServer: already running\n");
    }
    return sndServer;
}

+(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStarted) name:@"gameStarted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathBlocked) name:@"pathBlocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathLocked) name:@"pathLocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathUnlocked) name:@"pathUnlocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pathDark) name:@"pathDark" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerTookItem) name:@"playerTookItem" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterRoom:) name:@"playerDidEnterRoom" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUsedItem:) name:@"playerUsedItem" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDroppedItem) name:@"playerDroppedItem" object:nil];
}


/***********************
 *
 *  Notification methods
 *
 ***********************/

+(void)gameStarted {
    //how about some moody music
    NSSound* sound = [NSSound soundNamed:@"dark.mp3"];
    [sound retain];
    [sound setLoops: YES];
    [sound setVolume:.2];
    [sound play];
}

+(void)didEnterRoom:(NSNotification*)notification {
    Room* theRoom = (Room*)[notification object];
    
    //TODO check to see if the previous room is in the same environment, if so keep the current ambient sound playing
    if ([[theRoom tag] isEqualToString:@"a small family cemetery"] ) {
        [self changeAmbientSound:@"wind.mp3"];
    } else if ([[theRoom tag] isEqualToString:@"an underground cave"] || [[theRoom tag] isEqualToString:@"a long underground tunnel"]) {
        [self changeAmbientSound:@"cave.mp3"];
    } else {
        [self changeAmbientSound:nil];
    }
}

+(void)playerUsedItem:(NSNotification*) notification {
    NSString* itemName = (NSString*)[notification object];
    
    if ([itemName isEqualToString:@"lantern"]) {
        [self playSingle:@"match.mp3"];
    } else if ([itemName isEqualToString:@"axe"]) {
        [self playSingle:@"chop.mp3"];
    } else if ([itemName isEqualToString:@"key"]) {
        [self playSingle:@"unlock.mp3"];
    }  else if ([itemName isEqualToString:@"coal"]) {
        [self playSingle:@"coal.mp3"];
    }
}

+(void)playerTookItem {
    NSArray* sounds = [NSArray arrayWithObjects: @"backpack.mp3", @"backpack2.mp3", nil];
    int rand = arc4random() % [sounds count];
    [self playSingle:[sounds objectAtIndex:rand]];
    //[self playSingle:@"backpack.mp3"];
}

+(void)playerDroppedItem {
    NSArray* sounds = [NSArray arrayWithObjects: @"drop1.mp3", @"drop2.mp3", nil];
    int rand = arc4random() % [sounds count];
    [self playSingle:[sounds objectAtIndex:rand]];
    //[self playSingle:@"backpack.mp3"];
}

+(void)pathBlocked {
   NSLog(@"SoundServer: path blocked\n");
}

+(void)pathLocked {
    [self playSingle:@"locked.mp3"];
}

+(void)pathUnlocked {
    [self playSingle:@"creak.mp3"];
}

+(void)pathDark {
    NSLog(@"SoundServer: path dark\n");
}

/***********************
 *
 *  Helper methods
 *
 ***********************/

//changeAmbientSound should be used when changing environments
+(void)changeAmbientSound:(NSString*)theSoundName {
    [NSThread detachNewThreadSelector:@selector(T_changeAmbientSound:) toTarget:self withObject:theSoundName];
}

//T_changeAmbientSound should only be called from within changeAmbientSound
+(void)T_changeAmbientSound:(NSString*) theSoundName {
    //wait for other transitions to finish
    while (inTransition) {
        usleep(10000);
    }
    
    inTransition = true;
    
    //It's possible that the ambient sound isn't playing at full volume, or that it is nill
    //+ so we check each iteration then break.
    for(int i = 1; i < 100; i++) {
        [ambient setVolume: (1.0 / i)];
        usleep(60000);
        
        if ([ambient volume] < 0.1 || ambient == nil) {
            [ambient stop];
            [ambient release];
            ambient = nil;
            if (theSoundName) {
                ambient = [NSSound soundNamed:theSoundName];
                [ambient retain];
                [ambient setVolume:1.0];
                [ambient play];
            }
            break;
        }
    }
    
    inTransition = false;
}

//Play a sound effect once then exit
+(void)playSingle:(NSString*)theSoundName {
    if (theSoundName) {     //it would be better to also check if the file is in the bundle
        NSSound* theSound = [NSSound soundNamed:theSoundName];
        [theSound retain];
        [theSound setLoops: NO];
        [theSound setVolume:1.0];
        [theSound play];
        [theSound release];
    } else {
        NSLog(@"SoundServer:playSingle given nil filename");
    }
}

@end
