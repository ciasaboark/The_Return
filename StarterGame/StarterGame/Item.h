// Jonathan Nelson

#import <Cocoa/Cocoa.h>
#import "Room.h"

@interface Item : NSObject {
	NSString* name;
	NSString* description;
	Room* usedIn;	//what room we can use this item in
}

@property (retain, nonatomic)NSString* name;
@property (retain, nonatomic)NSString* description;
@property (retain, nonatomic)Room* usedIn;

-(id)init;
-(id)initWithName:(NSString *)newName andDescription:(NSString*) newDescription usedIn:(Room*) aRoom;


-(void)dealloc;

@end
