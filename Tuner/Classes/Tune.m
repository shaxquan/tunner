//
//  Tune.m
//  Tuner
//
//  Created by shaxquan  on 12/27/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import "Tune.h"

@implementation Tune
@synthesize name;
@synthesize file;

- (void)dealloc
{
    [super dealloc];
    [name release];
    [file release];
}
@end
