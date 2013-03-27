//
//  GameIO.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/13.
//  Copyright 2013 Columbus State University. All rights reserved.
//

#import "GameIO.h"

@implementation GameIO

-(id)initWithOutput:(NSTextFieldCell *)theOutput andNumberOfLines:(int)nLines
{
    self = [super init];
    
    if (nil != self) {
        output = theOutput;
        rowIndex = 0;
        rowTotal = nLines;
        lines = [[NSMutableArray alloc] initWithCapacity:rowTotal];
        [self clear];
    }
    
    return self;
}

-(void)sendLine:(NSString *)input
{
    [lines setObject:input atIndexedSubscript:rowIndex];
    rowIndex = (rowIndex + 1) % rowTotal;
    [self refreshOutput];
}

-(void)sendLines:(NSString *)input
{
    int offset = 81;

    NSArray *sLines = [input componentsSeparatedByString:@"\n"];
    for (id instance in sLines) {
        while ([instance length] > 81) {
            NSString* outLine;
            outLine = [instance substringToIndex:offset];
            instance = [instance substringFromIndex:offset];
            [self sendLine:i];
        }
        
        [self sendLine:instance];        
    }
    [self refreshOutput];
}

-(void)refreshOutput
{
    NSString *tempString = @"";
    int counter = 0;
    int tempIndex = rowIndex;
    while (counter < rowTotal) {
        tempString = [NSString stringWithFormat:@"%@%@\n", tempString, [lines objectAtIndex:tempIndex]];
        tempIndex = (tempIndex + 1) % rowTotal;
        counter++;
    }
    [output setStringValue:tempString];
}

-(void)clear
{
    for (int i = 0; i < rowTotal; i++) {
        [lines setObject:@"" atIndexedSubscript:i];
    }
}

-(void)dealloc
{
    [lines release];
    
    [super dealloc];
}

@end
