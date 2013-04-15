//
//  Player.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Player.h"


@implementation Player

@synthesize currentRoom;
@synthesize io;
@synthesize inventory;
@synthesize maxWeight;
@synthesize currentWeight;
@synthesize sleepRooms;
@synthesize hasTakenItem;
@synthesize startRoom;
@synthesize roomStack;
@synthesize points;
@synthesize codedPoints;

-(id)init
{
	return [self initWithRoom:nil andIO:nil];
}

-(id)initWithRoom:(NSMutableArray*)rooms andIO:(GameIO*)theIO
{
	self = [super init];
    
	if (nil != self) {
        int rand = arc4random() % [rooms count];
		[self setCurrentRoom:[rooms objectAtIndex:rand]];
        [self setIo:theIO];
        inventory = [[NSMutableDictionary alloc] init];
        [self setMaxWeight: 30];
        [self setCurrentWeight: 0];
        [self setSleepRooms: rooms];
        [self setHasTakenItem: false];
        [self setStartRoom: currentRoom];
        roomStack = [[NSMutableArray alloc] init];
        [self setPoints:0];

        codedPoints = BN_new(); //allocate and initialize
        BN_clear(codedPoints);  //set to 0
	}
    
	return self;
}

-(void)walkTo:(NSString*)direction
{
	Room* nextRoom = [currentRoom getExit:direction];
    if (nextRoom) {
        if ([[nextRoom tag] isEqualToString:@"blocked"] ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathBlocked" object:self];
            [self outputMessage:[NSString stringWithFormat:@"\nThe path %@ was blocked.  But there might have been a way around.\n", direction]];
        } else if ([[nextRoom tag] isEqualToString:@"locked"] ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathLocked" object:self];
            [self outputMessage:[NSString stringWithFormat:@"\nThe door %@ was locked.  There might have been a key.\n", direction]];
        } else if ([[nextRoom tag] isEqualToString:@"dark"] ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathDark" object:self];
            [self outputMessage:[NSString stringWithFormat:@"\nThe way %@ was too dark to proceed.\n", direction]];
        } else {            
            //We will pass this dictionary to the notifications to simplify the logic within
            //+ the soundServer.
            NSMutableDictionary* theRooms = [[NSMutableDictionary alloc] init];
            [theRooms setObject:currentRoom forKey:@"previous"];
            [theRooms setObject:nextRoom forKey:@"current"];


            [self pushRoom: currentRoom];
            [self setCurrentRoom:nextRoom];
            NSLog(@"player now in %@", nextRoom);
            
            //We can pretty things up a bit by using some random verbs
            NSArray* verbs = [NSArray arrayWithObjects: @"entered", @"walked into", @"made my way to", nil];
            int rand = arc4random() % [verbs count];

            
            [self outputMessage:[NSString stringWithFormat:@"\nI %@ %@.\n", [verbs objectAtIndex: rand], nextRoom]];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidRoomTransition" object:self userInfo:theRooms];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidEnterRoom" object:nextRoom];
            [theRooms autorelease];
        }
	} else {
        [self outputMessage:[NSString stringWithFormat:@"\nThere was no path %@.\n", direction]];
	}

}

-(void)outputMessage:(NSString*)message
{
    [io sendLines:message];
}


-(void)addItem:(Item*) anItem {
    if (anItem != nil) {
        [inventory setObject: anItem forKey: [anItem name]];
    }
}

-(BOOL)hasItem:(NSString*) itemName {
    BOOL response = NO;
    if ([[self inventory] objectForKey: itemName] != nil) {
        response = YES;
    }

    return response;
}

-(Item*)getItem:(NSString*)itemName {
    // Item* theItem = [inventory objectForKey: itemName];
    // [theItem retain];
    // return [theItem autorelease];
    return [inventory objectForKey: itemName];
}

-(Item*)removeItem:(NSString*) itemName {
    Item* theItem = [[self inventory] objectForKey: itemName];
    [theItem retain];
    [inventory removeObjectForKey: itemName];
    [self setCurrentWeight: [self currentWeight] - [theItem weight]];

    return [theItem autorelease];
}

-(unsigned long)invSize {
    return [inventory count];
}


-(void)addPoints:(unsigned int) morePoints {
    [self setPoints: points + morePoints];

    //create a new BUGNUM from morePoints
    unsigned long tmp_points = morePoints;
    BIGNUM* big_points = BN_new();
    BN_clear(big_points);
    BN_set_word(big_points, tmp_points);

    //we will need a context object to use as a scatchpad in the multiplication
    BN_CTX* ctx = BN_CTX_new();

    BN_mul(codedPoints, codedPoints, big_points, ctx);
    

    //deallocate the unneeded BIGNUMs
    BN_CTX_free(ctx);
    BN_free(big_points);

}

-(BOOL)hasViewed:(int) storyCode {
    BOOL result = NO;

    //we need an unsigned long instead of an int
    unsigned long tmp_code = storyCode;
    BIGNUM* big_code = BN_new();    //alloc and initialize
    BN_clear(big_code);             //set to zero
    BN_set_word(big_code, tmp_code);

    BIGNUM* rem = BN_new();
    BN_clear(rem);
    
    BN_CTX* ctx = BN_CTX_new();
    
    BN_mod(rem, codedPoints, big_code, ctx);
    int isZero = BN_is_zero(rem);
    
    if (isZero == 1) {
        result = YES;
    }

    BN_free(big_code);
    BN_free(rem);
    BN_CTX_free(ctx);

    return result;
}


-(void)pushRoom:(Room*)aRoom {
    [[self roomStack] addObject: aRoom];
}

-(Room*)popRoom {
    Room* theRoom = [[self roomStack] lastObject];
    [theRoom retain];
    [[self roomStack] removeLastObject];
    return [theRoom autorelease];
}

-(void)clearRoomStack {
    [[self roomStack] removeAllObjects];
}

-(void)dealloc {
	[currentRoom release];
    [io release];
    [inventory release];
    [sleepRooms release];
    [startRoom release];
    [roomStack release];
    BN_free(codedPoints);
         
	[super dealloc];
}

@end