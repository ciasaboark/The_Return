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
    //sendLine expects every incomming line to be able to fit in the width provided.  If there are
    //+ multiple lines that require wrapping then the content could be placed too far down to read.
    
    //To fix this we split every outgoing line into multiple lines of maxLength or less characters.
    
    //To keep the output from splitting mid-word we tokenize each word then check to see whether
    //+ adding that word would place the length over the max.
    
    //We keep track of spaces to make sure that lines of many short words do not go over the limit.
    int maxlength = 95;
    NSArray *sLines = [input componentsSeparatedByString:@"\n"];
    
    for (id string in sLines) {
        NSString* outLine = @"";
        NSArray* wordTokens = [string componentsSeparatedByString:@" "];
        int spaces = 0;
        
        for (id word in wordTokens) {
            if ([outLine length] + [word length] + spaces < maxlength) {
                outLine = [NSString stringWithFormat:@"%@%@ ", outLine, word];
                spaces++;                
            } else {
                //the line is too long, we need to start a new one
                [self sendLine:outLine];
                spaces = 0;
                outLine = [NSString stringWithFormat:@"%@ ", word];
            }
        }
        
      [self sendLine:outLine];
    }
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
