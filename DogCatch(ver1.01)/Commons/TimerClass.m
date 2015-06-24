//
//  TimerClass.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/13.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "TimerClass.h"

@implementation TimerClass
{
    //タイマー
    __weak NSTimer *_timer;
//    float timeCount;
    float _secondsOfTimer;
    NSString *_timeStr;
    CGFloat timeInterval;
}

-(NSString*)createTimeStrWithTimer:(NSTimer*)timer isStartPositionOfTime:(NSInteger)count
{
    CGFloat timeCount = count;
    
    //開始秒数を表すcount変数から、タイマー間隔と同数の数値を引くことにより、現在の残り時間を算出する
    timeCount = timeCount - timeInterval;
    float second = fmodf(timeCount,60);
    int minute = timeCount / 60;
    
    //現在の残り時間を、単位：秒（小数点以下２桁まで有効）でNSStringに格納する
    _timeStr = [NSString stringWithFormat:@"%02d:%05.2f",minute,second];
    
    return _timeStr;
}

-(void)startTimer:(CGFloat)intervalOfTime
{
    //引数intervalOfTimeを参照し、タイマーの間隔を設定する
    timeInterval = intervalOfTime;

    if(![_timer isValid]){
        _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(createTimeStrWithTimer:isStartPositionOfTime:)userInfo:nil repeats:YES];
    }

}

@end
