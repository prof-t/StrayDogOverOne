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


    if([player isPlaying]){
        
        //すでに再生中であれば、何もしない
        NSLog(@"すでに再生中です");
        
    }else{

        NSString *path = [[NSBundle mainBundle] pathForResource:@"c6" ofType:@"mp3"];
        player = [AudioSingleton createPlayerWithURLString:path forKey:@"タイトル画面"];
        player.numberOfLoops = -1;
        [player play];
        
    }
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
    NSURL *bgm2URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"se9" ofType:@"wav"] ];
    _playerEffect = [[AVAudioPlayer alloc]initWithContentsOfURL:bgm2URL error:nil];
    self.playerEffect.numberOfLoops = 0;
    [self.playerEffect play];
    
}

//easyボタンtap時のイベント
- (IBAction)gameStartEasy:(id)sender {
    
    NSURL *bgm2URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"se9" ofType:@"wav"] ];
    _playerEffect = [[AVAudioPlayer alloc]initWithContentsOfURL:bgm2URL error:nil];
    self.playerEffect.numberOfLoops = 0;
    [self.playerEffect play];
}

//ルール説明ボタンtap時のイベント
- (IBAction)tutorialScreen:(id)sender
{

    NSURL *bgm3URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"decision23" ofType:@"mp3"] ];
    _playerEffect2 = [[AVAudioPlayer alloc]initWithContentsOfURL:bgm3URL error:nil];
    self.playerEffect2.numberOfLoops = 0;
    [self.playerEffect2 play];

}

//遷移時に数値を渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    

    if ( ([segue.identifier isEqualToString:@"moveToNormalGameScreen"]) ||([segue.identifier isEqualToString:@"moveToEasyModeScreen"])  ) {
        
        GameScreenViewController *gvsc= (GameScreenViewController*)[segue destinationViewController];
        gvsc.questionNumber = 0;
        
        //遷移時に音楽をフェードアウトする
        [self bgmStopWithFadeOut];
        NSLog(@"BGM STOP!");
    }
    
    if([segue.identifier isEqualToString:@"moveToTutorialScreen"]){
        
        TutorialScreenViewController *tsvc= (TutorialScreenViewController*)[segue destinationViewController];
        tsvc.player = player;
        
    }
}


-(void)bgmStopWithFadeOut
{
    if (player.volume > 0.1) {
        player.volume = player.volume - 0.1;
        [self performSelector:@selector(bgmStopWithFadeOut) withObject:nil afterDelay:0.5];
    }else{
        [player stop];

    }
}



@end



















