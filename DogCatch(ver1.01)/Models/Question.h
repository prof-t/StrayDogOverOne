//
//  Question.h
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
//　クイズが正解か失敗かを判断し、その結果を受けて残り時間で得点を評価するクラス

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Question : NSObject

/**
　isCorrect変数を指定し、クイズが正解か失敗かを判断する。その際、指定したremainTimeに応じた得点を返す。
 
 @param isCorrect 正解ならYES,失敗ならNO
 @param remainTime クイズに回答した時点での残り時間（単位:秒 小数点2桁まで有効）
 @return 評価に応じた得点を返す
 
*/
-(NSInteger)evaluateScoreWithIsCorrect:(BOOL)isCorrect remainTime:(float)remainTime  completion:(void (^)(NSInteger score))completion;

/**
 問題の出題パターンを決定する
 */
-(BOOL)decisionQuestionPattern;

@end
