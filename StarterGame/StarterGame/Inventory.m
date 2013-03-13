// Jonathan Nelson

#import <Cocoa/Cocoa.h>
#import "Item.h"
#import "Inventory.h"

@implementation Inventory

@synthesize inv;

-(id)init {
	self = [super init];

	if (self != nil) {
		inv = [[NSMutableArray alloc] initWithCapacity:30];
	}

	return self;
}

-(void)addItem:(Item*) anItem {
	if (![inv containsObject: anItem]) {
		[inv addObject: anItem];
		[anItem retain];
	}
}

-(void)dealloc {
	[inv release];

	[super dealloc];
}

@end
