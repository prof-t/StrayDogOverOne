//
//  TutorialScreenViewController.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/14.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "TutorialScreenViewController.h"

@interface TutorialScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *page1;
@property (weak, nonatomic) IBOutlet UILabel *page2;
@property (weak, nonatomic) IBOutlet UILabel *page3;
@property (weak, nonatomic) IBOutlet UIImageView *dogall;

@end

@implementation TutorialScreenViewController
{
    int pageNumber;
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
    
    pageNumber = 1;
    self.page1.hidden = NO;
    self.page2.hidden = YES;
    self.page3.hidden=YES;
    self.dogall.hidden = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)titleScreen:(id)sender
{
    NSURL *bgm3URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"decision23" ofType:@"mp3"] ];
    _playerEffect2 = [[AVAudioPlayer alloc]initWithContentsOfURL:bgm3URL error:nil];
    self.playerEffect2.numberOfLoops = 0;
    [self.playerEffect2 play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//遷移時に数値を渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"returnTitleScreen"]){
        
        //遷移時に音楽をフェードアウトする
        [self.player stop];
    }
}

- (IBAction)nextTutorial:(id)sender
{
    if(pageNumber == 1){
        
        self.page1.hidden = YES;
        self.page2.hidden = NO;
        self.page3.hidden=YES;
           self.dogall.hidden = YES;
        
        pageNumber = pageNumber + 1;
        
    } else if(pageNumber == 2){
        
        self.page1.hidden = YES;
           self.dogall.hidden = YES;
        self.page2.hidden = YES;
        self.page3.hidden=NO;
        
           pageNumber = pageNumber + 1;
        
    } else if(pageNumber == 3){
        
        self.page1.hidden = NO;
           self.dogall.hidden = NO;
        self.page2.hidden = YES;
        self.page3.hidden=YES;
        
        pageNumber = 1;
        
    }else {
        
    }
}

-(void)bgmStopWithFadeOut
{
    
    if (self.player.volume > 0.1) {
        self.player.volume = self.player.volume - 0.1;
        [self performSelector:@selector(bgmStopWithFadeOut) withObject:nil afterDelay:1.0];
    }else{
        [self.player stop];
        
    }
}
@end
