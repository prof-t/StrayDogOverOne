//
//  TimerClass.h
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/13.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
//タイマーを起動し、クイズの残り時間（（単位:秒 小数点2桁まで有効））を計測するクラス

#import <Foundation/Foundation.h>
#import"GameScreenViewController.h"

@interface TimerClass : NSObject

/**
 isStartPositionOfTimeからtimerの間隔に応じて残り時間をカウントダウンし、現在の残り時間を返すメソッド。
 
 @param timer タイマー。
 @param isStartPositionOfTime 残り時間をカウントダウンしていくにあたって、何秒からスタートするかの初期数値
 @return 残り時間（単位：秒　小数点２桁まで有効）をNSStringで返す
 */
-(NSString*)createTimeStrWithTimer:(NSTimer*)timer isStartPositionOfTime:(NSInteger)count;



/**
 intervalOfTimeで指定した間隔でタイマーを発生させるメソッド。セレクターで　createTimeStrWithTimer:isStartPositionOfTime　メソッドを呼び出す
 
 @param intervalOfTimer タイマーの間隔を指定する
 */
-(void)startTimer:(CGFloat)intervalOfTime;

@end
