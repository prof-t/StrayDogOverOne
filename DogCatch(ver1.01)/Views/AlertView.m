//
//  AlertView.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/24.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView


//-(UIAlertController *)makeAlertController
//{
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ゲームを終了しますか？" message:@"This is message." preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertController *__weak weakAlert = alert;
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"終了しない" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            [weakAlert dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:defaultAction];
//        
//        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"終了する" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
//            
//            [_timer invalidate];//Timerを止める
//            TitleScreenViewController *titleVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"TitleScreen"];//title画面に遷移する
//            [self presentViewController:titleVC animated:YES completion:nil];//YESならModal,Noなら何もなし
//            [AudioSingleton stopAudioWithKey:@"ゲーム中"];//音楽も止める
//            [weakAlert dismissViewControllerAnimated:YES completion:nil];
//            
//        }];
//        [alert addAction:cancelAction];
//        
//        //    UIAlertAction *altAction = [UIAlertAction actionWithTitle:@"ルール説明を見る" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
//        
//        //ルール説明のmodalを表示する
//        
//        //        [weakAlert dismissViewControllerAnimated:YES completion:nil];
//        //    }];
//        //    [alert addAction:altAction];
//
//    
//    
//}






@end
