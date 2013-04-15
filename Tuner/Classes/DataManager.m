//
//  DataManager.m
//  Tuner
//
//  Created by shaxquan  on 12/11/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import "DataManager.h"

static DataManager *instance = nil;

@implementation DataManager
@synthesize tuneOrder;
@synthesize currentInstrument;
+ (DataManager *)sharedDataManager
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[DataManager alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSArray *)loadMusicInstrumnetList
{
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"instrumentlist" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *listArray = [NSArray arrayWithArray:[root objectForKey:@"InstrumentList"]];
    
    return listArray;
}

- (NSDictionary *)loadGuitarTune
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"guitar" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    self.tuneOrder = [NSArray arrayWithObjects:@"e", @"B", @"G", @"D", @"A", @"F", nil];
    
    return root;
}

- (void)dealloc
{
    [super dealloc];
}



@end
