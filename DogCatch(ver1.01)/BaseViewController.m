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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

//どの方向に回転していいかを返す（例ではすべての方向に回転OK）
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
