//
//  GuitarTune.h
//  Tuner
//
//  Created by shaxquan  on 12/27/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tune.h"

@interface GuitarTune : NSObject {
    Tune *eTune;
    Tune *BTune;
    Tune *GTune;
    Tune *DTune;
    Tune *ATune;
    Tune *FTune;
}

@property (nonatomic, retain) Tune *eTune;
@property (nonatomic, retain) Tune *BTune;
@property (nonatomic, retain) Tune *GTune;
@property (nonatomic, retain) Tune *DTune;
@property (nonatomic, retain) Tune *ATune;
@property (nonatomic, retain) Tune *FTune;
 
@end
