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

@interface GameScreenViewController : BaseViewController<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *dogButton1;
@property (weak, nonatomic) IBOutlet UIButton *dogButton2;
@property (weak, nonatomic) IBOutlet UIButton *dogButton3;
@property (weak, nonatomic) IBOutlet UIButton *dogButton4;
@property (weak, nonatomic) IBOutlet UIButton *dogButton5;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gameStartButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gameCancelButton;

@property int questionNumber;

@property (weak, nonatomic) IBOutlet UIImageView *girlImage;
@property (weak, nonatomic) IBOutlet UILabel *questionColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScore;

@property (nonatomic,copy) NSString* timeStr;

-(void)setButtonActionAndColor:(NSString*)action color:(NSString*)colorStr tag:(int)tag;

@end
