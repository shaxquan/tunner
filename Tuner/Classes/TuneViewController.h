//
//  TuneViewController.h
//  Tuner
//
//  Created by shaxquan  on 12/11/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    k12stepdown,
    kDropD,
    kStandard,
    
    kAcro=10,
    kPizz,
} TurningMode;

@class CMOpenALSoundManager;

@interface TuneViewController : UIViewController<UIAlertViewDelegate> {
    CMOpenALSoundManager *soundMgr;
    NSDictionary *instrumentDict;
    TurningMode currentMode;
    NSInteger tuneNumbers;
    NSInteger previousSoundID;
}

@end
