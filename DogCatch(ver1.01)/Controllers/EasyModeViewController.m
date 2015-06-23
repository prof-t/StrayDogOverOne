//
//  EasyModeViewController.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/05/13.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "EasyModeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface EasyModeViewController ()

// クイズの回答後に表示されるViewとImageView
@property (nonatomic,weak) IBOutlet UIView *clearView;
@property (nonatomic,weak) IBOutlet UIImageView *clearViewImage;

// 回答ボタン
@property (nonatomic,weak) IBOutlet UIButton *dogButton1;
@property (nonatomic,weak) IBOutlet UIButton *dogButton2;
@property (nonatomic,weak) IBOutlet UIButton *dogButton3;

// ゲームスタートボタン
@property (nonatomic,weak) IBOutlet UIBarButtonItem *gameStartButton;
// ゲームキャンセル（中断）ボタン
@property (nonatomic,weak) IBOutlet UIBarButtonItem *gameCancelButton;

// 女の子のImageView
@property (nonatomic,weak) IBOutlet UIImageView *girlImage;

// 問題文を表示するLabel
@property (nonatomic,weak) IBOutlet UILabel *questionColorLabel;
@property (nonatomic,weak) IBOutlet UILabel *questionActionLabel;

// 残り時間を表示するLabel
@property (nonatomic,weak) IBOutlet UILabel *timeLabel;

// scoreの累計を表示するLabel
@property (nonatomic,weak) IBOutlet UILabel *totalScore;

@end

@implementation EasyModeViewController
{
    NSInteger correctButtonTag; //正解ボタンのタグ番号
    BOOL questionPattern; //設問パターン
     
    //タイマー
    __weak NSTimer *_timer;
    CGFloat timeCount;
    CGFloat _secondsOfTimer;
    NSString *_timeStr;
    
    NSInteger nowScore; //現在の得点
    Question *questionClassOBJ;
    BOOL _correctOrWrong;
}


@synthesize timeStr;


//初期化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    [self setBackGroudImageName:@"back1.jpg"];
    
    nowScore = 0;
    questionClassOBJ = [[Question alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//キャンセルボタン押下時のイベント処理
- (IBAction)pushedCancelButton:(UIBarButtonItem*)button
{
    //アラートの表示（iOS8か否かで処理が分岐する）
//    if( [[UIDevice currentDevice].systemVersion floatValue] < 8) {
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
    
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"ゲームを終了しますか？" delegate:self cancelButtonTitle:@"ゲームを終了しない" destructiveButtonTitle:@"ゲームを終了してタイトル画面に戻る" otherButtonTitles:nil];
    [as showInView:self.view];
    
    } else {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ゲームをやめますか？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertController *__weak weakAlert = alert;
        
        //「ゲームをやめる」のをやめる際の処理
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"やめない" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:defaultAction];
        
        //「ゲームをやめる」際の処理
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"やめる" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
            
            [_timer invalidate];//Timerを止める
            TitleScreenViewController *titleVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"TitleScreen"];//title画面に遷移する
            [self presentViewController:titleVC animated:YES completion:nil];//YESならModal,Noなら何もなし
            [AudioSingleton stopAudioWithKey:@"ゲーム中"];//音楽も止める
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [alert addAction:cancelAction];
        
        //    UIAlertAction *altAction = [UIAlertAction actionWithTitle:@"ルール説明を見る" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        
        //ルール説明のmodalを表示する
        
        //        [weakAlert dismissViewControllerAnimated:YES completion:nil];
        //    }];
        //    [alert addAction:altAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//スタートボタン押下時のイベント処理
- (IBAction)pushedStartButton:(UIBarButtonItem*)button
{
    button.enabled = NO;
    self.clearView.hidden =YES;
    self.clearView.hidden =YES;
    
    //女の子の顔画像を変更
    self.girlImage.image = [UIImage imageNamed:@"girl3.jpg"];
    
    //ボタンのhiddenを解除
    self.dogButton1.enabled = YES;
    self.dogButton2.enabled = YES;
    self.dogButton3.enabled = YES;
    
    //今回の設問パターン（YES/NO）を決定
    questionPattern = [self questionPattern:(int)self.questionNumber];
    
    //設問パターンをもとに、正解ボタンと失敗ボタンを生成し、同時に設問文の表示を行う
    [self decidedQuestion:questionPattern label1:self.questionColorLabel label2:self.questionActionLabel];
    
    //音楽START！
    [AudioSingleton playAudioWithKey:@"ゲーム中"];
    
    //timer起動
//    TimerClass *timerTest = [TimerClass alloc];
//    [timerTest startTimer:60];
    [self timerStart];
    
    //labelテキストを随時変更
    NSLog(@"%@",timeStr);
    self.timeLabel.text = timeStr;
    
    UINavigationBar *navBar = (UINavigationBar*)[self.view viewWithTag:10];
    navBar.topItem.title = @"犬をタッチしてつかまえてね!!";
}

//回答ボタンを押下時のイベント処理
- (IBAction)pushedAnswerButton:(UIButton*)button
{
    //タイマーと音楽のストップ
    [_timer invalidate];
    [AudioSingleton stopAudioWithKey:@"ゲーム中"];
    
    //ゲームクリアー画面のviewを表示させる
    self.clearView.hidden = NO;
    self.clearViewImage.hidden = NO;
    
    UINavigationBar *navBar = (UINavigationBar*)[self.view viewWithTag:10];
    
    
    //効果音、得点の増減、正解か不正解の値渡しを行う
    if(button.tag == correctButtonTag + 1){

        [AudioSingleton playAudioWithKey:@"正解"];
        nowScore = [questionClassOBJ evaluateScoreWithIsCorrect:YES remainTime:timeCount completion:^(NSInteger score) {

        }] + nowScore;
        _correctOrWrong = YES;
        self.clearViewImage.image =[UIImage imageNamed:@"girl2.jpg"];
        navBar.topItem.title = @"おめでとう!!";
        
    } else {
        NSLog(@"残念！！");
        nowScore = [questionClassOBJ evaluateScoreWithIsCorrect:NO remainTime:timeCount completion:^(NSInteger score) {
            
        }] + nowScore;

        [AudioSingleton playAudioWithKey:@"失敗"];
        _correctOrWrong = NO;
        self.clearViewImage.image =[UIImage imageNamed:@"girl1.jpg"];
        navBar.topItem.title = @"残念!!";
    }
    
    //現在の総得点をNSString化してlabelに表示
    NSString *nowScoreStr = [[NSString alloc]initWithFormat:@"総得点 %ld",(long)nowScore];
    self.totalScore.text = nowScoreStr;
    
    //ボタンが何度も押されるのを防ぐため、enabledをnoに設定
    self.dogButton1.enabled = NO;
    self.dogButton2.enabled = NO;
    self.dogButton3.enabled = NO;
    
    //スタートボタンのenabledをyesにし、次の問題に移れるようにする
    self.gameStartButton.enabled = YES;
    
    //ボタンの円半径の設定を、画面変化に対応させる
    //        sender.layer.cornerRadius = (self.view.bounds.size.width / 2) * 1.0f;
    //            sender.layer.masksToBounds = YES;
    
    
}


//ハズレボタンの色とアクションを設定
-(void)setButtonActionAndColor:(NSString*)action color:(NSString*)colorStr tag:(NSInteger)tag
{
    UIButton *button = (UIButton*)[self.view viewWithTag:(int)tag];
    
    if([action isEqualToString:@"ハスキー"]){
        [button setBackgroundImage:[UIImage imageNamed:@"hasky.png"] forState:UIControlStateNormal];
    } else if([action isEqualToString:@"ミニチュアシュナウザー"]){
        [button setBackgroundImage:[UIImage imageNamed:@"shuna.png"] forState:UIControlStateNormal];
    } else if([action isEqualToString:@"ポメラニアン"]){
        [button setBackgroundImage:[UIImage imageNamed:@"pome.png"] forState:UIControlStateNormal];
    } else if([action isEqualToString:@"コリー"]){
        [button setBackgroundImage:[UIImage imageNamed:@"koly.png"] forState:UIControlStateNormal];
    } else if([action isEqualToString:@"しば犬"]){
        [button setBackgroundImage:[UIImage imageNamed:@"shiba.png"] forState:UIControlStateNormal];
    } else {
        NSLog(@"画像の設定にミスあり");
    }
    
    
    if([colorStr isEqualToString:@"赤"]){
        button.backgroundColor = [UIColor redColor];
    } else if([colorStr isEqualToString:@"青"]){
        button.backgroundColor = [UIColor blueColor];
    } else if([colorStr isEqualToString:@"黄"]){
        button.backgroundColor = [UIColor yellowColor];
    } else if([colorStr isEqualToString:@"緑"]){
        button.backgroundColor = [UIColor greenColor];
    } else if([colorStr isEqualToString:@"茶"]){
        button.backgroundColor = [UIColor brownColor];
    }
    
}

/* ★☆★設問パターンをランダムに決めるメソッド★☆★ */
-(BOOL)questionPattern:(NSInteger)questionNumber
{
    BOOL pattern = arc4random()% 2;

    //問題数のカウントを＋１しておく
    self.questionNumber = self.questionNumber + 1;
    
    return pattern;
}

/*　★☆★　各ボタンの種類と色を決定し、設問文を表示するメソッド　★☆★　*/
-(void)decidedQuestion:(BOOL)pattern label1:(UILabel*)label1 label2:(UILabel*)label2
{
    
    //材料としてアクションと色の配列を用意する
    NSMutableArray* allAction = [NSMutableArray array];
    [allAction addObject:@"ハスキー"];
    [allAction addObject:@"しば犬"];
    [allAction addObject:@"ポメラニアン"];
    [allAction addObject:@"ミニチュアシュナウザー"];
    [allAction addObject:@"コリー"];
    
    NSMutableArray *allColor = [NSMutableArray array];
    [allColor addObject:@"赤"];
    [allColor addObject:@"青"];
    [allColor addObject:@"黄"];
    [allColor addObject:@"緑"];
    [allColor addObject:@"茶"];
    
    NSNumber* tag1 = @1;
    NSNumber* tag2 = @2;
    NSNumber* tag3 = @3;

    
    NSMutableArray *allTag = [NSMutableArray array];
    [allTag addObject:tag1];
    [allTag addObject:tag2];
    [allTag addObject:tag3];

    
    NSString* wrongActionLabel;
    NSString* wrongColorLabel;
    
    
    //①まず、今回の正解のアクションと色をランダムに決める
    NSInteger correctAction = arc4random() % 5;
    NSString* correctActionStr = [allAction objectAtIndex:correctAction];
    
    NSInteger correctColor = arc4random() % 5;
    NSString* correctColorStr = [allColor objectAtIndex:correctColor];
    
    
    //②正解ボタンをボタン1〜３のどれにするかをランダムに決める
    correctButtonTag = arc4random() % 3;
    NSInteger correctButtonTagNumber = [[allTag objectAtIndex:correctButtonTag]intValue];
    
    
    //③正解ボタンのアクションと色を設定する
    [self setButtonActionAndColor:correctActionStr color:correctColorStr tag:correctButtonTagNumber];
    NSLog(@"正解ボタンの色：%@　アクション：%@　tag：%d",correctColorStr,correctActionStr,correctButtonTagNumber);
    
    //④正解ボタンのアクションと色は、もう使わないのでarrayから削除する
    [allAction removeObjectAtIndex:correctAction];
    [allColor removeObjectAtIndex:correctColor];
    [allTag removeObjectAtIndex:correctButtonTag];
    
    
    //⑤後の説明文表示に使うので、新たにNSMutableArrayを作成する（要素の０は「正しいアクション」要素の１は「正しい色」となる）
    NSMutableArray *arrayForQuestionLabel = [NSMutableArray array];
    [arrayForQuestionLabel addObject:correctActionStr];
    [arrayForQuestionLabel addObject:correctColorStr];
    
    
    //⑥不正解ボタンのアクションと色を設定する
    for(NSInteger i=1;i<=2;i++){
        
        NSInteger wrongAction = arc4random() % [allAction count];
        NSString* wrongActionStr = [allAction objectAtIndex:wrongAction];
        
        NSInteger wrongColor = arc4random() % [allColor count];
        NSString* wrongColorStr = [allColor objectAtIndex:wrongColor];
        
        //⑥−1　不正解ボタンを1〜３のどれにするかを決める
        NSInteger wrongButtonTag = arc4random() % [allTag count];
        NSInteger wrongButtonTagNumber = [[allTag objectAtIndex:wrongButtonTag]intValue];

        //⑥−2　不正解ボタンのアクションと色を設定し、更に設問ラベル用に変数に格納しておく（周回によってどれにいれるか決める）
        [self setButtonActionAndColor:wrongActionStr color:wrongColorStr tag:wrongButtonTagNumber];
        
        if(i ==1){
            wrongActionLabel = wrongActionStr;
        }else if(i == 2){
            wrongColorLabel = wrongColorStr;
        }
        
        //⑥−3　不正解ボタンのアクションと色は、もう使わないのでarrayから削除する
        [allAction removeObjectAtIndex:wrongAction];
        [allColor removeObjectAtIndex:wrongColor];
        [allTag removeObjectAtIndex:wrongButtonTag];
        
        //⑥−4　説明文表示用に、NSMutableArrayに順番に要素を格納しておく
        [arrayForQuestionLabel addObject:wrongActionStr];
        [arrayForQuestionLabel addObject:wrongColorStr];
    }
    
    //arrayの中身を試しに取り出してみよう
    //    int j=0;
    //    for (NSString *str in arrayForQuestionLabel) {
    //        NSLog(@"%d %@",j, str);
    //        j++;
    //    }
    
    
    //⑦設問文の表示（パターンによって処理が分岐する）
    NSMutableString *labelText1 =[[NSMutableString alloc]initWithString:@"わたしのワンちゃんは…\n　"];
    NSMutableString *labelText2 = [[NSMutableString alloc]initWithString:@"くびわ の いろ は…\n　"];
    
    //⑦−1　設問パターンがYESの場合
    if(pattern == YES){
        
        [labelText1 appendString:correctActionStr];
        [labelText1 appendString:@"…？"];
        [label1 setText:labelText1];
        
        [labelText2 appendString:correctColorStr];
        [labelText2 appendString:@"いろだったの…"];
        [label2 setText:labelText2];
        
        
        //⑦−2　設問パターンがNOの場合
    } else if(pattern == NO){
        
        //不正解ボタンから、まずランダムで1つ選ぶ。その1つが不正解アクションになる。
        //残りの１つを不正解色にする
        
        [labelText1 appendString:wrongActionLabel];
        [labelText1 appendString:@"…？"];
        [label1 setText:labelText1];
        
        [labelText2 appendString:wrongColorLabel];
        [labelText2 appendString:@"いろだったの…"];
        [label2 setText:labelText2];
        
    }
}

-(void)timer:(NSTimer*)timer
{
    
    timeCount = timeCount - 0.01f;
    float second = fmodf(timeCount,60);
    _timeStr = [NSString stringWithFormat:@"残り時間 %05.2f",second];
    
    self.timeLabel.text = _timeStr;
    
    //    UILabel *time =(UILabel*)[self.view viewWithTag:TIME];
    //    time.text =[[NSString alloc]initWithFormat:@"%@",timeStr];
    //
    //    if(timeCount >20){
    //        UIImageView *miss = (UIImageView*)[self.view viewWithTag:MISS];
    //        miss.image = [UIImage imageNamed:@"失敗.png"];
    //        score =  score - 500;
    //        [timer invalidate];
    //    }
    
}

-(void)timerStart
{
    timeCount = 60;
    if(![_timer isValid]){
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
    
}


@end
