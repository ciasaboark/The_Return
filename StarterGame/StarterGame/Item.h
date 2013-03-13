// Jonathan Nelson

#import <Cocoa/Cocoa.h>
#import "Room.h"

@interface Item : NSObject {
	NSString* name;
	NSString* description;
	Room* usedIn;	//what room we can use this item in
	int weight;		//how much this item weighs.  Items that can not be collected should have a weight of > 30
}

@property (retain, nonatomic)NSString* name;
@property (retain, nonatomic)NSString* description;
@property (retain, nonatomic)Room* usedIn;
@property (nonatomic)int weight;

-(id)init;
-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom andWeight:(int) aWeight;


-(void)dealloc;

@end
