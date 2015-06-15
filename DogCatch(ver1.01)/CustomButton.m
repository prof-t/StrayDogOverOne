//
//  CustomButton.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//storyboardでの生成時に使うカスタム設定
- (void)awakeFromNib
{
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderWidth  = self.borderWidth ;
    self.layer.borderColor = [self.borderColor CGColor];
}

@end
