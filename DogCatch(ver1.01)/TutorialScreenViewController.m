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

//ボタンのイベント処理
- (IBAction)titleScreen:(id)sender
{
    //効果音を鳴らす
    [AudioSingleton playAudioWithKey:@"ルール説明ボタン"];
}

//遷移時の処理
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"returnTitleScreen"]){
        
        //遷移時に音楽をストップする
        [AudioSingleton stopAudioWithKey:@"タイトル画面"];
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

@end
