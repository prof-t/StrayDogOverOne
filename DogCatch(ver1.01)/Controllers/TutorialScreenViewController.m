//
//  TutorialScreenViewController.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/14.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "TutorialScreenViewController.h"

@interface TutorialScreenViewController ()

//説明画面の各ページとして使用するUILabel
@property (nonatomic,weak) IBOutlet UILabel *page1;
@property (nonatomic,weak) IBOutlet UILabel *page2;
@property (nonatomic,weak) IBOutlet UILabel *page3;

//説明画面内で使用するImageView
@property (nonatomic,weak) IBOutlet UIImageView *dogall;

@end

@implementation TutorialScreenViewController
{
    NSInteger pageNumber;
}

#pragma mark - Public Methods
#pragma mark - Private Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    [self setBackGroudImageName:@"back1.jpg"];
    
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
- (IBAction)pushedTitleButton:(UIButton*)button
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

- (IBAction)pushedNextTutorialButton:(UIButton*)button
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
