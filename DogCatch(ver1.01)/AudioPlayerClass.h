//
//  AudioPlayerClass.h
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/18.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<AVFoundation/AVFoundation.h>

#define AudioSingleton [AudioPlayerClass sharedInstance]

/**
 シングルトンのサンプルクラス
 */
@interface AudioPlayerClass : NSObject

/**
 シングルトンのインスタンスを取得する
 @return シングルトンのインスタンスを返す。
 @note 必須
 */
+ (instancetype)sharedInstance;


// 以下サウンドオブジェクトを管理するサンプルメソッドです。


/**
 サウンドオブジェクトの生成(URL)
 @param url resourceのpathURL
 @param key サウンドオブジェクトの名前。nilを設定するとコンテナに保持しない。同じ名前の場合は上書きする。
 @return サウンドオブジェクトを生成して返す
 @note 任意
 */
- (AVAudioPlayer *)createPlayerWithURL:(NSURL *)url forKey:(NSString *)key;


/**
 サウンドオブジェクトの生成(URL文字列)
 @param urlString resourceのpathString
 @param key サウンドオブジェクトの名前。nilを設定するとコンテナに保持しない。同じ名前の場合は上書きする。
 @return サウンドオブジェクトを生成して返す
 @note 任意
 */
- (AVAudioPlayer *)createPlayerWithURLString:(NSString *)urlString forKey:(NSString *)key;

/**
 サウンドオブジェクトの取得
 @param key サウンドオブジェクトの名前
 @return keyに一致するサウンドオブジェクトを返す。なければnilを返す。
 @note 任意
 */
- (AVAudioPlayer *)playerWithKey:(NSString *)key;

/**
 サウンドオブジェクトの破棄
 @param key サウンドオブジェクトの名前
 @note 任意
 */
- (void)deletePlayerWithKey:(NSString *)key;

/**
 全サウンドオブジェクトの破棄
 @note 任意
 */
- (void)deleteAllPlayer;


@end