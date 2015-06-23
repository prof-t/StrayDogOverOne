//
//  TitleScreenViewController.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "TitleScreenViewController.h"

@interface TitleScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonNormal;
@property (weak, nonatomic) IBOutlet UIButton *buttonEasy;
@property (weak, nonatomic) IBOutlet UIButton *buttonHard;
@property (weak, nonatomic) IBOutlet UIButton *buttonTutorial;

@end

@implementation TitleScreenViewController
{
    AVAudioPlayer *player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"back1.jpg"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    //角丸設定
//    [[self.buttonNormal layer] setCornerRadius:5.0];
//    [self.buttonNormal setClipsToBounds:YES];
    

    //音楽の生成と再生
    player = [AudioSingleton createPlayerWithFileName:@"c6.mp3" forKey:@"タイトル画面"];
    //    player.numberOfLoops = -1;
    [AudioSingleton playAudioWithKey:@"タイトル画面"];
    
    //以降の画面で必要な音楽データを、あらかじめコンテナに格納
    [AudioSingleton createPlayerWithFileName:@"カジノ4.mp3" forKey:@"ゲーム中"];
    [AudioSingleton createPlayerWithFileName:@"correct2.mp3" forKey:@"正解"];
    [AudioSingleton createPlayerWithFileName:@"d6.mp3" forKey:@"失敗"];
    [AudioSingleton createPlayerWithFileName:@"se9.wav" forKey:@"ゲームモード選択"];
    [AudioSingleton createPlayerWithFileName:@"decision23.mp3" forKey:@"ルール説明ボタン"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//normalボタンtap時のイベント
- (IBAction)gameStartNormal:(id)sender
{
    //効果音再生
    [AudioSingleton playAudioWithKey:@"ゲームモード選択"];
}

//easyボタンtap時のイベント
- (IBAction)gameStartEasy:(id)sender {
    //効果音再生
    [AudioSingleton playAudioWithKey:@"ゲームモード選択"];
}

//ルール説明ボタンtap時のイベント
- (IBAction)tutorialScreen:(id)sender
{
    //効果音再生
    [AudioSingleton playAudioWithKey:@"ルール説明ボタン"];
}

//遷移時の処理
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ( ([segue.identifier isEqualToString:@"moveToNormalGameScreen"]) ||([segue.identifier isEqualToString:@"moveToEasyModeScreen"])  ) {
        
        NormalScreenViewController *gvsc= (NormalScreenViewController*)[segue destinationViewController];
        gvsc.questionNumber = 0;
        
        //遷移時に音楽をフェードアウトする
        [AudioSingleton fadeOutAudioWithKey:@"タイトル画面"];
    }
    
    //TutorialScreenViewControllerに遷移する際の処理
    if([segue.identifier isEqualToString:@"moveToTutorialScreen"]){
        
    }
}

@end