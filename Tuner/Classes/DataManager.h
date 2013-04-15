//
//  DataManager.h
//  Tuner
//
//  Created by shaxquan  on 12/11/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kGuitar = 1,
    kViolin,
} InstrumentName;

@interface DataManager : NSObject
{
    NSArray *tuneOrder;
    InstrumentName currentInstrument;
}

@property (nonatomic, retain) NSArray *tuneOrder;
@property (nonatomic, assign) InstrumentName currentInstrument;
+ (DataManager *)sharedDataManager;
- (NSArray *)loadMusicInstrumnetList;
- (NSDictionary *)loadGuitarTune;
@end
