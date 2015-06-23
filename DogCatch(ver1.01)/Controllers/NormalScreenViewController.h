//
//  GameScreenViewController.h
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
//ゲーム画面(normalモード)のviewController

#import <UIKit/UIKit.h>
#import "Question.h"
#import<AVFoundation/AVFoundation.h>
#import"TimerClass.h"
#import"TitleScreenViewController.h"
#import "BaseViewController.h"
#import "SDAudioPlayerManager.h"

@interface NormalScreenViewController : BaseViewController<UIActionSheetDelegate>

@property (nonatomic,assign) NSInteger questionNumber;
@property (nonatomic,copy) NSString* timeStr;

@end
