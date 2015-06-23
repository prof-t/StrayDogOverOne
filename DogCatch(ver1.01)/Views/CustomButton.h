//
//  CustomButton.h
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
//　awakeFromNibメソッドにより、InterfaceBuilderで配置したボタンが生成される際に、任意の設定を適用させるクラス

#import <UIKit/UIKit.h>
#import "NormalScreenViewController.h"

@interface CustomButton : UIButton

@property (nonatomic, assign) int cornerRadius;
@property (nonatomic, assign) int borderWidth;
@property (nonatomic, assign) UIColor* borderColor;

@end
