//
//  AlertView.h
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/24.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
// ゲーム中断のYES/NOアラートを表示するためのクラス

#import <UIKit/UIKit.h>

@interface AlertView : NSObject

/**
 初期化する
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message owner:(UIViewController *)owner;

/**
 add
 */
- (void)addLabel:(NSString *)label handler:(void (^)(void))handler;

/**
 show
 */
- (void)show;

/**
 Alertを閉じる
*/
-(void)dismiss;

@end
