//
//  BaseViewController.h
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/17.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
//画面回転を制御するためのクラス

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/**
背景画像をセットする
 @param key 背景画像のファイル名
*/
-(void)setBackGroudImageName:(NSString *)imageName;

@end
