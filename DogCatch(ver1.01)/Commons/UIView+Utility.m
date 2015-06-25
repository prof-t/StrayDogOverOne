//
//  UIView+Utility.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/25.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "UIView+Utility.h"

@implementation UIView (Utility)

- (UIImage *)exchangeToImage
{
    // 必要なUIImageサイズ分のコンテキスト確保
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画像化する部分の位置を調整
    CGContextTranslateCTM(context, -self.frame.origin.x, -self.frame.origin.y);
    
    // 画像出力
    [self.layer renderInContext:context];
    
    // uiimage化
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // コンテキスト破棄
    UIGraphicsEndImageContext();
    
    return renderedImage;
}

@end
