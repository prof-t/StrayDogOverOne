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
    
    
    
    //音楽START！
    if([self.player isPlaying]){
        
        NSLog(@"すでに再生中です");
        
    }else{
        
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"c6" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    [self.player play];
    
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



- (IBAction)gameStartNormal:(id)sender
{
    NSURL *bgm2URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"se9" ofType:@"wav"] ];
    _playerEffect = [[AVAudioPlayer alloc]initWithContentsOfURL:bgm2URL error:nil];
    self.playerEffect.numberOfLoops = 0;
    [self.playerEffect play];
    
}

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
    

    if([segue.identifier isEqualToString:@"movoToGameScreen"]){
        
        GameScreenViewController *gvsc= (GameScreenViewController*)[segue destinationViewController];
        gvsc.questionNumber = 0;
        
        //遷移時に音楽をフェードアウトする
        [self bgmStopWithFadeOut];
    }
    
    if([segue.identifier isEqualToString:@"moveToTutorialScreen"]){
        
        TutorialScreenViewController *tsvc= (TutorialScreenViewController*)[segue destinationViewController];
        tsvc.player = self.player;
        
    }
}


-(void)bgmStopWithFadeOut
{

    if (self.player.volume > 0.1) {
        self.player.volume = self.player.volume - 0.1;
        [self performSelector:@selector(bgmStopWithFadeOut) withObject:nil afterDelay:0.5];
    }else{
        [self.player stop];

    }
}

//画面回転時に呼ばれるメソッド（iOS6以前のみ。7以降は使用不可）
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    
//    if(toInterfaceOrientation == UIDeviceOrientationLandscapeLeft){
//        return YES;
//    } else {
//        return NO;
//    }
//}

//ここで回転していいかの判別をする
- (BOOL)shouldAutorotate
{
//    if (/* なにがしかの回転していいかの判定処理 */) {
//        return YES;
//    }
    
    return NO;
}

//どの方向に回転していいかを返す（例ではすべての方向に回転OK）
//- (NSUInteger)supportedInterfaceOrientations
//{
//    //rotateManagerは、向き変更可かどうかを管理するためのグローバルオブジェクト
//    UIViewControllerRotateManager *rotateManager
//    
//    
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}

@end



















