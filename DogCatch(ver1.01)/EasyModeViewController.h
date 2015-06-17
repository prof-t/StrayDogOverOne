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
#import "ClearScreenViewController.h"
#import "BaseViewController.h"

@interface EasyModeViewController : BaseViewController<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *dogButton1;
@property (weak, nonatomic) IBOutlet UIButton *dogButton2;
@property (weak, nonatomic) IBOutlet UIButton *dogButton3;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *gameStartButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gameCancelButton;

@property int questionNumber;
@property AVAudioPlayer *player;
@property AVAudioPlayer *playerEffect;

@property (weak, nonatomic) IBOutlet UIImageView *girlImage;
@property (weak, nonatomic) IBOutlet UILabel *questionColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScore;

@property (nonatomic,copy) NSString* timeStr;

-(void)setButtonActionAndColor:(NSString*)action color:(NSString*)colorStr tag:(int)tag;

@end