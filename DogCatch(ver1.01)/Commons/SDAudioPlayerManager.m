//
//  AudioPlayerClass.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/18.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "SDAudioPlayerManager.h"

@interface SDAudioPlayerManager()

// サウンドオブジェクトのコンテナを用意（AVAudioPlayerのインスタンスを保持するため）
@property (nonatomic, strong)NSMutableDictionary *players;

@end

@implementation SDAudioPlayerManager



#pragma mark - Public Methods

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (AVAudioPlayer *)createPlayerWithURL:(NSURL *)url forKey:(NSString *)key
{
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    // コンテナにセット
    if (key) {
        self.players[key] = player;
    }
    
    return player;
}

- (AVAudioPlayer *)createPlayerWithURLString:(NSString *)urlString forKey:(NSString *)key
{
    NSURL *url = [NSURL fileURLWithPath:urlString];
    return [self createPlayerWithURL:url forKey:key];
}

- (AVAudioPlayer *)createPlayerWithFileName:(NSString *)fileName forKey:(NSString *)key
{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    return [self createPlayerWithURLString:pathString forKey:key];
}

- (AVAudioPlayer *)createPlayerWithFileName:(NSString *)fileName forKey:(NSString *)key loop:(NSInteger)loop
{
   AVAudioPlayer *player = [self createPlayerWithFileName:fileName forKey:key];
    player.numberOfLoops = loop;
    return player;
}

- (AVAudioPlayer *)playerWithKey:(NSString *)key
{
    if (!key) {
        return nil;
    }
    
    return self.players[key];
}

- (void)deletePlayerWithKey:(NSString *)key
{
    if (!key) {
        return;
    }
    
    // サウンドを停止する
    AVAudioPlayer *player = self.players[key];
    if ([player isPlaying]) {
        [player stop];
        //再生位置を頭から
        player.currentTime = 0;
    }
    
    [self.players removeObjectForKey:key];
}

- (void)deleteAllPlayer
{
    // すべてのサウンドを停止する
    for (AVAudioPlayer *player in self.players) {
        if ([player isPlaying]) {
            [player stop];
            //再生位置を頭から
            player.currentTime = 0;
        }
    }
    [self.players removeAllObjects];
}

-(BOOL)playAudioWithKey:(NSString *)key{
    
    AVAudioPlayer *player = [self playerWithKey:key];
    return [player play];
}

-(void)stopAudioWithKey:(NSString *)key{
    AVAudioPlayer *player = [self playerWithKey:key];
    [player stop];
    //再生位置を頭から
    player.currentTime = 0;
}

-(void)fadeOutAudioWithKey:(NSString *)key
{
    AVAudioPlayer *player = [self playerWithKey:key];
    
    if (player.volume > 0.1) {
        player.volume = player.volume - 0.1;
        [self performSelector:@selector(fadeOutAudioWithKey:) withObject:key afterDelay:0.5];
        
    }else{
        [player stop];
        //再生位置を頭から
        player.currentTime = 0;
    }
}

#pragma mark - Private Methods

// playerコンテナの取得
- (NSMutableDictionary *)players
{
    if (!_players) {
        //初期化
        _players = [@{} mutableCopy];
    }
    return _players;
}



@end