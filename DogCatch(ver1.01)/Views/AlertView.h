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
 アラートの生成
 @param title actionを引数にアラートを生成するクラス
 @param title
 @param message
 @param style
 @param firstAction
 @param secondAction
 @return 生成したUIAlertControllerを返す
 */
-(UIAlertController *)makeAlertControllerWithTitleWithAction:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle *)style firstAction:(UIAlertAction *)firstAction secondAction:(UIAlertAction *)secondAction;

/**
 アラートにアクションを設定する
 @param
 @param
 */
//-(UIAlertAction *)makeAlertActionWithTitle:(NSString *)title style:(UIAlertActionStyle *)style handler:( ? )handler;

/**
 アラートアクション内のイベント処理メソッド
 @param
 @param
 */

@end
