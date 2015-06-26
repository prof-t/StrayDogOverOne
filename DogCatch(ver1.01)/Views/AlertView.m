//
//  AlertView.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/24.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView


-(UIAlertController *)makeAlertControllerWithTitleWithAction:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle *)style firstAction:(UIAlertAction *)firstAction secondAction:(UIAlertAction *)secondAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:*style];
    
//    UIAlertController *__weak weakAlert = alert;
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    return alert;
    
}

//AlertAction生成のメソッド
//-(UIAlertAction *)makeAlertActionWithTitle:(NSString *)title style:(UIAlertActionStyle *)style handler:( ? )handler
//{
//    return [UIAlertAction actionWithTitle:title style:style handler:handler];
//}

//AlertActionのイベント処理




@end
