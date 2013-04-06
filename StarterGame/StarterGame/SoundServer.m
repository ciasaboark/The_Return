//
//  SoundServer.m
//  The Return

#import "SoundServer.h"


@implementation SoundServer

@synthesize ambient;

static NSSound* ambient;
//static bool inTransition;
static NSMutableArray* transitionRequests;

+(id)sharedInstance {
    static SoundServer* sndServer = nil;
    if (!sndServer) {
        sndServer = [[[self class] alloc] init];
        ambient = nil;
        //inTransition = false;
        transitionRequests = [[NSMutableArray alloc] initWithCapacity:10];
        [self registerForNotifications];
    } else {
        NSLog(@"SoundServer: already running\n");
    }

    //we will let a background thread handle changing the ambient sounds
    //[self spawnAmbientWatcher];
    [NSThread detachNewThreadSelector:@selector(T_ambientSoundManager) toTarget:self withObject:nil];

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRoomTransition:) name:@"playerDidRoomTransition" object:nil];
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
    [[sound autorelease] play];
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


+(void)didRoomTransition:(NSNotification*)notification {
  //  Room* previous = [[notification userInfo] objectForKey:@"previous"];
  //  Room* current = [[notification userInfo] objectForKey:@"current"];

    //check each room for a type

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
}

+(void)playerDroppedItem {
    NSArray* sounds = [NSArray arrayWithObjects: @"drop1.mp3", @"drop2.mp3", nil];
    int rand = arc4random() % [sounds count];
    [self playSingle:[sounds objectAtIndex:rand]];
}

+(void)pathBlocked {
   NSLog(@"SoundServer: path blocked unimplemented\n");
}

+(void)pathLocked {
    [self playSingle:@"locked.mp3"];
}

+(void)pathUnlocked {
    [self playSingle:@"creak.mp3"];
}

+(void)pathDark {
    NSLog(@"SoundServer: path dark unimplemented\n");
}

/***********************
 *
 *  Helper methods
 *
 ***********************/

//changeAmbientSound should be used when changing environments
+(void)changeAmbientSound:(NSString*)theSoundName {
    //nil can not be inserted into an NSArray
    NSLog(@"SoundServer: changing ambient sound to : %@", theSoundName);
    if (theSoundName) {
        [transitionRequests addObject:theSoundName];
    }
}

+(void)spawnAmbientWatcher {
    //[NSThread detachNewThreadSelector:@selector(T_ambientSoundManager) toTarget:self ];
}

+(void)T_ambientSoundManager {
    //run in a constant loop looking for sound change requests
    while (true) {
        if ([transitionRequests count] != 0) {
            NSLog(@"SoundServer: found a transition request");
            NSString* requestedFileName = [transitionRequests objectAtIndex:0];
            [requestedFileName retain];
            [transitionRequests removeObjectAtIndex:0];

            //if we are transitioning to a room with the same ambient sound then just keep playing
            //+ the same sound
            if (!([[ambient name] isEqualToString:requestedFileName]) || ambient == nil) {
                //It's possible that the ambient sound isn't playing at full volume, or that it is nill
                //+ so we check each iteration then break.
                for(int i = 1; i < 100; i++) {
                    [ambient setVolume: (1.0 / i)];
                    usleep(60000);
                    
                    if ([ambient volume] < 0.1 || ambient == nil) {
                        [ambient stop];
                        [ambient release];
                        ambient = nil;
                        if (requestedFileName) {
                            ambient = [NSSound soundNamed:requestedFileName];
                            [ambient retain];
                            [ambient setVolume:1.0];
                            [ambient play];
                        }
                        break;
                    }
                }
                usleep(10000);
            } else {
                NSLog(@"SoundServer: transitioning to a room with the same ambient sound, not changing");
            }
            [requestedFileName release];
        } else {
            //wait a bit before we check again
            usleep(10000);
        }
    }
}

//T_changeAmbientSound should only be called from within changeAmbientSound
// +(void)T_changeAmbientSound:(NSString*) theSoundName {
//     //wait for other transitions to finish
//     while (inTransition) {
//         usleep(10000);
//     }
    
//     inTransition = true;
    
//     //It's possible that the ambient sound isn't playing at full volume, or that it is nill
//     //+ so we check each iteration then break.
//     for(int i = 1; i < 100; i++) {
//         [ambient setVolume: (1.0 / i)];
//         usleep(60000);
        
//         if ([ambient volume] < 0.1 || ambient == nil) {
//             [ambient stop];
//             [ambient release];
//             ambient = nil;
//             if (theSoundName) {
//                 ambient = [NSSound soundNamed:theSoundName];
//                 [ambient retain];
//                 [ambient setVolume:1.0];
//                 [ambient play];
//             }
//             break;
//         }
//     }
    
//     inTransition = false;
// }

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
