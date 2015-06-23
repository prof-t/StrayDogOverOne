//
//  BaseViewController.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/17.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return YES;
}

//どの方向に回転していいかを返す
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

-(void)setBackGroudImageName:(NSString *)imageName{
    
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:imageName] drawInRect:self.view.bounds];
        UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];

}

@end
