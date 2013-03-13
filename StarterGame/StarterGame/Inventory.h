// Jonathan Nelson

#import <Cocoa/Cocoa.h>
#import "Item.h"

@interface Inventory : NSObject {
	NSMutableArray* inv;
}

@property (retain, nonatomic)NSMutableArray* inv;

-(id)init;
-(void)addItem:(Item*) anItem;

-(void)dealloc;

@end
