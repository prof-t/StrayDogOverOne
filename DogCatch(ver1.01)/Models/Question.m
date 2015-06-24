//
//  Question.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "Question.h"

@implementation Question

#pragma mark - public methods
//得点加算メソッド
-(NSInteger)evaluateScoreWithIsCorrect:(BOOL)isCorrect remainTime:(float)remainTime  completion:(void (^)(NSInteger score))completion
{
    NSInteger score;
    
    //時間切れだったら-500点
    if (remainTime <= 0){
        score = - 500;
        return score;
    }
    
    //正解だったら残り秒数に×１００点する
    if(isCorrect == YES){
        score = remainTime * 10;
    } else {
        //失敗だったら−300点
        score = - 300;
    }
    
    return score;
}

/* ★☆★設問パターンをランダムに決めるメソッド★☆★ */
-(BOOL)decisionQuestionPattern
{
    BOOL pattern = arc4random()% 2;
    return pattern;
}
@end
