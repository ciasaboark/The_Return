//
//  GameIO.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/13.
//  Copyright 2013 Columbus State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameIO : NSObject{
    NSTextFieldCell *output;
    NSMutableArray *lines;
    int rowTotal;
    int rowIndex;
}

-(id)initWithOutput:(NSTextFieldCell *)theOutput andNumberOfLines:(int)nLines;
-(void)sendLine:(NSString *)input;
-(void)sendLines:(NSString *)input;
-(void)refreshOutput;
-(void)clear;

@end
