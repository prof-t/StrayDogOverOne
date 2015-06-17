//
//  Question.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "Question.h"

@implementation Question
{
    NSNumber *button1RandomDogColor,*button2RandomDogColor,*button3RandomDogColor,*button4RandomDogColor,*button5RandomDogColor;
    NSNumber *button1RandomDogAction,*button2RandomDogAction,*button3RandomDogAction,*button4RandomDogAction,*button5RandomDogAction;
    
}

#pragma mark - public methods
//得点加算メソッド
-(NSInteger)evaluateScoreWithIsCorrect:(BOOL)isCorrect remainTime:(float)remainTime  completion:(void (^)(NSInteger score))completion
{
    int score;
    
    //正解だったら残り秒数に×１００点する
    if(isCorrect == YES){
        
        score = remainTime * 10;
        
        //失敗だったら−300点
    } else if(isCorrect == NO){
        
        score = - 300;
        
        //時間切れだったら-500点
    } else if(time <= 0){
        
        score = - 500;
    }
    
    completion(score);
    
    return score;
}

@end
