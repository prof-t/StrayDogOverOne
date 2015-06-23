//
//  EasyModeViewController.h
//  StrayDogOverOne
//
//  Created by RYO on 2015/05/13.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
//ゲーム画面(easyモード)のviewController

#import <UIKit/UIKit.h>
#import "Question.h"
#import<AVFoundation/AVFoundation.h>
#import"TimerClass.h"
#import"TitleScreenViewController.h"
#import "BaseViewController.h"
#import "SDAudioPlayerManager.h"

@interface EasyModeViewController : BaseViewController<UIActionSheetDelegate>

@property (nonatomic,assign) NSInteger *questionNumber;
@property (nonatomic,copy) NSString* timeStr;

@end