//
//  AudioPlayerClass.h
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/18.
//  Copyright (c) 2015年 RYO. All rights reserved.
//
//AudioPlayerのインスタンスを作成し、保持するクラス

#import <Foundation/Foundation.h>
#import<AVFoundation/AVFoundation.h>

#define AudioSingleton [SDAudioPlayerManager sharedInstance]

/**
 シングルトンのサンプルクラス
 */
@interface SDAudioPlayerManager : NSObject

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
 サウンドオブジェクトの生成(ファイル名)
 @param fileName resource（main bundle）にある任意のファイル名(拡張子付き)
 @param key サウンドオブジェクトの名前。nilを設定するとコンテナに保持しない。同じ名前の場合は上書きする。
 @return サウンドオブジェクトを生成して返す
 */
- (AVAudioPlayer *)createPlayerWithFileName:(NSString *)fileName forKey:(NSString *)key;

/**
サウンドオブジェクトの生成(ファイル名)
@param fileName resource（main bundle）にある任意のファイル名(拡張子付き)
@param key サウンドオブジェクトの名前。nilを設定するとコンテナに保持しない。同じ名前の場合は上書きする。
@param loop ループ回数の指定
@return サウンドオブジェクトを生成して返す
*/
- (AVAudioPlayer *)createPlayerWithFileName:(NSString *)fileName forKey:(NSString *)key loop:(NSInteger)loop;

/**
 サウンドオブジェクトの取得
 @param key サウンドオブジェクトの名前
 @return keyに一致するサウンドオブジェクトを返す。なければnilを返す。
 */
- (AVAudioPlayer *)playerWithKey:(NSString *)key;

/**
 サウンドオブジェクトの破棄
 @param key サウンドオブジェクトの名前
 */
- (void)deletePlayerWithKey:(NSString *)key;

/**
 全サウンドオブジェクトの破棄
 */
- (void)deleteAllPlayer;

/**
 サウンドオブジェクトの再生
 @param key サウンドオブジェクトの名前
 */
-(BOOL)playAudioWithKey:(NSString *)key;

/**
 サウンドオブジェクトの停止
 @param key サウンドオブジェクトの名前
 */
-(void)stopAudioWithKey:(NSString *)key;

/**
 サウンドオブジェクトの音量をフェイドアウトさせて消す
 @param key サウンドオブジェクトの名前
 */
-(void)fadeOutAudioWithKey:(NSString *)key;


@end