//
//  ClearScreenViewController.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "ClearScreenViewController.h"
#import "GameScreenViewController.h"

@interface ClearScreenViewController ()

@end

@implementation ClearScreenViewController

//初期化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"back1.jpg"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];

    
    _imageView = [self makeImageView:self.view.frame];
    
        NSLog(@"正解？失敗？%d",self.correctOrWrong);
    
    if(self.correctOrWrong == YES){
        _imageView.image=[UIImage imageNamed:@"girl2.jpg"];
    } else {
    _imageView.image=[UIImage imageNamed:@"girl1.jpg"];
    }
        [self.view addSubview:_imageView];
}

// タッチ終了時に呼ばれる
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    // ビューの生成
    UIImageView* nextView=[self makeImageView:_imageView.frame];
    nextView.image=[UIImage imageNamed:@"girl2.jpg"];
    
    //UIView アニメーションの設定開始
    [UIView beginAnimations:@"transition" context:NULL];
    [UIView setAnimationDuration:1.0f];
    
    // トランジションアニメーションの設定
    UIViewAnimationTransition transition=0;
    if (_animeIdx==3) transition=UIViewAnimationTransitionCurlUp;
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    
    // ビューの変更
    [_imageView removeFromSuperview];
    _imageView=nextView;
    [self.view addSubview:_imageView];
    
    //UIView アニメーションの実行
    [UIView commitAnimations];
    
}

- (UIImageView*)makeImageView:(CGRect)rect
{
    UIImageView* imageView=[[UIImageView alloc] init];
    imageView.frame=rect;
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask=
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleBottomMargin;
    imageView.backgroundColor=[UIColor whiteColor];
    return imageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    //    [super viewDidAppear:animated];
    
    //    //SKViewオブジェクトの生成と追加
    ////    SKView *skViewOBJ = [[SKView alloc]initWithFrame:self.view.frame];
    //    self.skview.showsFPS = YES;
    //    self.skview.showsNodeCount = YES;
    //    [self.view addSubview:self.skview];
    //
    //    //SKSceneオブジェクトの生成と配置
    //    SKScene *scene1 = [MyScene sceneWithSize:skViewOBJ.bounds.size];
    //    scene1.scaleMode = SKSceneScaleModeAspectFill;
    //    scene1.userInteractionEnabled = YES;
    //    [self.skview presentScene:scene1];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    //シーンオブジェクトの追加
    //    SKScene *scene2 = [[SKScene alloc]initWithSize:self.view.frame.size];
    //
    //    //トランジションオブジェクトの追加
    //    SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:2];
    //
    //    //トランジションを使ったシーンの切り替え
    //    [self.view presentScene:scene2 transition:transition];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
