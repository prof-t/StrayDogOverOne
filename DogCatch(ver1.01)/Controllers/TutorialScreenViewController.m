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

//説明画面のviewの現在のページを表す
@property (nonatomic,assign) NSInteger currentPageNumber;

@end

@implementation TutorialScreenViewController

#pragma mark - Public Methods
#pragma mark - Private Methods

//初期化
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.currentPageNumber = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    [self setBackGroudImageName:@"back1.jpg"];
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
    }
}

- (IBAction)pushedNextTutorialButton:(UIButton*)button
{
    if(self.currentPageNumber == 1){
        
        self.page1.hidden = YES;
        self.page2.hidden = NO;
        self.page3.hidden=YES;
        self.dogall.hidden = YES;
        
        self.currentPageNumber = self.currentPageNumber + 1;
        
    } else if(self.currentPageNumber == 2){
        
        self.page1.hidden = YES;
        self.dogall.hidden = YES;
        self.page2.hidden = YES;
        self.page3.hidden=NO;
        
        self.currentPageNumber = self.currentPageNumber + 1;
        
    } else if(self.currentPageNumber == 3){
        
        self.page1.hidden = NO;
        self.dogall.hidden = NO;
        self.page2.hidden = YES;
        self.page3.hidden=YES;
        
        self.currentPageNumber = 1;
        
    }else {
        
    }
}

@end
