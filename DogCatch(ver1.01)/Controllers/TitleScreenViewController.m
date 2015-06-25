//
//  TitleScreenViewController.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "TitleScreenViewController.h"

@interface TitleScreenViewController ()

//ボタン
@property (nonatomic,weak) IBOutlet UIButton *buttonNormal;
@property (nonatomic,weak) IBOutlet UIButton *buttonEasy;
@property (nonatomic,weak) IBOutlet UIButton *buttonHard;
@property (nonatomic,weak) IBOutlet UIButton *buttonTutorial;

@end

@implementation TitleScreenViewController

#pragma mark - Public Methods
#pragma mark - Private Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    [self setBackGroudImageName:@"back1.jpg"];
    
    //角丸設定
//    [[self.buttonNormal layer] setCornerRadius:5.0];
//    [self.buttonNormal setClipsToBounds:YES];

    //音楽の生成と再生
    [AudioSingleton playAudioWithKey:SDAudioFileName_BGMTitleScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ゲームスタートボタンtap時のイベント
- (IBAction)pushedGameStartButton:(UIButton*)button
{
    //効果音再生
    [AudioSingleton playAudioWithKey:SDAudioFileName_SETutorial002];
}

//ルール説明ボタンtap時のイベント
- (IBAction)pushedTutorialButton:(UIButton*)button
{
    //効果音再生
    [AudioSingleton playAudioWithKey:SDAudioFileName_SETutorial001];
}

//遷移時の処理
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ( ([segue.identifier isEqualToString:@"moveToNormalGameScreen"]) ||([segue.identifier isEqualToString:@"moveToEasyModeScreen"])  ) {
        
        NormalScreenViewController *gvsc= (NormalScreenViewController*)[segue destinationViewController];
        gvsc.questionNumber = 0;
        
        //遷移時に音楽をフェードアウトする
        [AudioSingleton fadeOutAudioWithKey:SDAudioFileName_BGMTitleScreen];
    }
    
    //TutorialScreenViewControllerに遷移する際の処理
    if([segue.identifier isEqualToString:@"moveToTutorialScreen"]){
        
    }
}

@end