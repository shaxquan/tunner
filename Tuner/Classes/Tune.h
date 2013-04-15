//
//  Tune.h
//  Tuner
//
//  Created by shaxquan  on 12/27/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tune : NSObject {
    NSString *name;
    NSString *file;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *file;
@end
