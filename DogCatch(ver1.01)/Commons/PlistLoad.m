//
//  PlistLoad.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/24.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "PlistLoad.h"
#import "SDAudioPlayerManager.h"

@implementation PlistLoad

+ (void)loadAudioFilePlist
{
    //plistをロードする
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDPreloadingAudioFiles" ofType:@"plist"];
    NSArray *plists = [NSArray arrayWithContentsOfFile:path];
    
    //plistの中身を表示
    for (NSDictionary *audioInfo in plists){
        //音声ファイル名
        NSString *fileName = audioInfo[@"fileName"];
        //key名
        NSString *key = audioInfo[@"key"];
        //ループ設定
        NSNumber *loop = audioInfo[@"loop"];
        
        //SDAudioPlayerManagerで音声ファイルをロード
        [[SDAudioPlayerManager sharedInstance] createPlayerWithFileName:fileName
                                                                 forKey:key loop:[loop intValue]];
    }
}
@end
