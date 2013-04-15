//
//  GuitarTune.m
//  Tuner
//
//  Created by shaxquan  on 12/27/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import "GuitarTune.h"

@implementation GuitarTune
@synthesize eTune, BTune, GTune, DTune, ATune, FTune;

- (void)dealloc
{
    [super dealloc];
    [eTune release];
    [BTune release];
    [GTune release];
    [DTune release];
    [ATune release];
    [FTune release];
}
@end
