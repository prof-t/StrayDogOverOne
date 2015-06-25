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

@interface EasyModeViewController : BaseViewController<UIActionSheetDelegate>

// 第何問目なのかを表す値を保持する
@property (nonatomic,assign) NSInteger *questionNumber;

// ゲームの残り時間を表す数字の文字列
@property (nonatomic,copy) NSString* timeStr;

@end