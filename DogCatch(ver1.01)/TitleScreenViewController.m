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
    [AudioSingleton createPlayerWithFileName:@"se9.wav" forKey:@"ゲームモード選択"];
    //    player.numberOfLoops = -1;
    [AudioSingleton playAudioWithKey:@"ゲームモード選択"];
    
}

//easyボタンtap時のイベント
- (IBAction)gameStartEasy:(id)sender {
    
    //効果音再生
    [AudioSingleton createPlayerWithFileName:@"se9.wav" forKey:@"ゲームモード選択"];
    //    player.numberOfLoops = -1;
    [AudioSingleton playAudioWithKey:@"ゲームモード選択"];
}

//ルール説明ボタンtap時のイベント
- (IBAction)tutorialScreen:(id)sender
{
    //効果音再生
    [AudioSingleton createPlayerWithFileName:@"decision23.mp3" forKey:@"ルール説明ボタン"];
    //    player.numberOfLoops = -1;
    [AudioSingleton playAudioWithKey:@"ルール説明ボタン"];

}

//遷移時に数値を渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    

    if ( ([segue.identifier isEqualToString:@"moveToNormalGameScreen"]) ||([segue.identifier isEqualToString:@"moveToEasyModeScreen"])  ) {
        
        GameScreenViewController *gvsc= (GameScreenViewController*)[segue destinationViewController];
        gvsc.questionNumber = 0;
        
        //遷移時に音楽をフェードアウトする
        [AudioSingleton fadeOutAudioWithKey:@"タイトル画面"];
//        [self bgmStopWithFadeOut];
    }
    
    if([segue.identifier isEqualToString:@"moveToTutorialScreen"]){
        
//        TutorialScreenViewController *tsvc= (TutorialScreenViewController*)[segue destinationViewController];
//        tsvc.player = player;
        
    }
}


//-(void)bgmStopWithFadeOut
//{
//    if (player.volume > 0.1) {
//        player.volume = player.volume - 0.1;
//        NSLog(@"ボリューム下げてるよ");
//        [self performSelector:@selector(bgmStopWithFadeOut) withObject:nil afterDelay:0.5];
//
//    }else{
//        [player stop];
//
//    }
//}



@end



















