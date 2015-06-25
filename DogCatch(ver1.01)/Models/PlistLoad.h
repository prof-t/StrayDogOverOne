//
//  PlistLoad.h
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/24.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
// 音楽ファイルデータを登録した.plistを取り扱うクラス

#import <Foundation/Foundation.h>

@interface PlistLoad : NSObject

/**
 plistからAudioFileを読み込み、SDAudioManagerを生成するメソッド
 */
+(void)loadAudioFilePlist;

@end
