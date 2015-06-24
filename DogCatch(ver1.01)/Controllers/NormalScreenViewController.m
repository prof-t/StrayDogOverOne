//
//  GameScreenViewController.m
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "NormalScreenViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NormalScreenViewController ()

// クイズの回答後に表示されるViewとImageView
@property (nonatomic,weak) IBOutlet UIView *clearView;
@property (nonatomic,weak) IBOutlet UIImageView *clearViewImage;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

// 回答ボタン
@property (nonatomic,weak) IBOutlet UIButton *dogButton1;
@property (nonatomic,weak) IBOutlet UIButton *dogButton2;
@property (nonatomic,weak) IBOutlet UIButton *dogButton3;
@property (nonatomic,weak) IBOutlet UIButton *dogButton4;
@property (nonatomic,weak) IBOutlet UIButton *dogButton5;

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
@property (nonatomic,weak) NSTimer *timer;

@end

@implementation NormalScreenViewController
{
    NSInteger correctButtonTag;
    BOOL questionPattern;
    
    //タイマー
//    __weak NSTimer *_timer;
    float timeCount;
    
    NSInteger nowScore;
    Question *questionClassOBJ;
    BOOL _correctOrWrong;
}

#pragma mark - Public Methods
#pragma mark - Private Methods

//初期化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    [self setBackGroudImageName:@"back1.jpg"];
    
    nowScore = 0;
    questionClassOBJ = [Question alloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pushedCancelButton:(UIBarButtonItem*)button
{
    //アラートの表示（iOS8か否かで処理が分岐する）
    if( [[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ゲームを終了しますか？" message:@"This is message." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertController *__weak weakAlert = alert;
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"終了しない" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:defaultAction];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"終了する" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
            
            [_timer invalidate];//Timerを止める
            TitleScreenViewController *titleVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"TitleScreen"];//title画面に遷移する
            [self presentViewController:titleVC animated:YES completion:nil];//YESならModal,Noなら何もなし
            [AudioSingleton stopAudioWithKey:@"ゲーム中"];//音楽も止める
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [alert addAction:cancelAction];
//
//        //    UIAlertAction *altAction = [UIAlertAction actionWithTitle:@"ルール説明を見る" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
//        
//        //ルール説明のmodalを表示する
//        
//        //        [weakAlert dismissViewControllerAnimated:YES completion:nil];
//        //    }];
//        //    [alert addAction:altAction];
    
        [self presentViewController:alert animated:YES completion:nil];
        
        
    } else {
        
        UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"ゲームを終了しますか？" delegate:self cancelButtonTitle:@"ゲームを終了しない" destructiveButtonTitle:@"ゲームを終了してタイトル画面に戻る" otherButtonTitles:nil];
        [as showInView:self.view];
        
    }
    
}

- (IBAction)pushedStartButton:(UIBarButtonItem*)button
{
    button.enabled = NO;
    self.clearView.hidden =YES;
    self.clearView.hidden =YES;
    
    //女の子の顔画像を変更
    self.girlImage.image = [UIImage imageNamed:@"girl3.jpg"];
    
    
    
    /*★☆★　動作確認用テスト★☆★*/
    //ボタンのhiddenを解除
    self.dogButton1.enabled = YES;
    self.dogButton2.enabled = YES;
    self.dogButton3.enabled = YES;
    self.dogButton4.enabled = YES;
    self.dogButton5.enabled = YES;
    
    //今回の設問パターン（YES/NO）を決定
    questionPattern = [self questionPattern:self.questionNumber];
    
    //設問パターンをもとに、正解ボタンと失敗ボタンを生成し、同時に設問文の表示を行う
    [self decidedQuestion:questionPattern label1:self.questionColorLabel label2:self.questionActionLabel];
    
    //音楽START！
    [AudioSingleton playAudioWithKey:@"ゲーム中"];
    
    //timer起動
//    TimerClass *timerTest = [TimerClass alloc];
    [self timerStart];
    
    //labelテキストを随時変更
    self.timeLabel.text = self.timeStr;
    
    self.navBar.topItem.title = @"犬をタッチしてつかまえてね!!";
}

- (IBAction)pushedAnswerButton:(UIButton*)button
{
    
    [_timer invalidate];
    [AudioSingleton stopAudioWithKey:@"ゲーム中"];

    self.clearView.hidden = NO;
    self.clearViewImage.hidden = NO;
    
    //効果音、得点の増減、正解か不正解の値渡しを行う
    if(button.tag == correctButtonTag + 1){
        //正解の効果音を鳴らす
        [AudioSingleton playAudioWithKey:@"正解"];
        
        //この問題での得点と、今までに得た得点を足して、総合計を算出する
        nowScore = [questionClassOBJ evaluateScoreWithIsCorrect:YES remainTime:timeCount completion:^(NSInteger score) {
            
        }] + nowScore;
        _correctOrWrong = YES;
        self.clearViewImage.image =[UIImage imageNamed:@"girl2.jpg"];
        self.navBar.topItem.title = @"おめでとう!!";
        
    } else {
        //不正解の効果音を鳴らす
        [AudioSingleton playAudioWithKey:@"失敗"];
        
        //この問題での得点と、今までに得た得点を足して、総合計を算出する
        nowScore = [questionClassOBJ evaluateScoreWithIsCorrect:NO remainTime:timeCount completion:^(NSInteger score) {
            
        }] + nowScore;
        
        _correctOrWrong = NO;
        self.clearViewImage.image =[UIImage imageNamed:@"girl1.jpg"];
        self.navBar.topItem.title = @"残念!!";
    }
    
    NSString *nowScoreStr = [[NSString alloc]initWithFormat:@"総得点 %zd",nowScore];
    self.totalScore.text = nowScoreStr;
    
    self.dogButton1.enabled = NO;
    self.dogButton2.enabled = NO;
    self.dogButton3.enabled = NO;
    self.dogButton4.enabled = NO;
    self.dogButton5.enabled = NO;
    
    
    self.gameStartButton.enabled = YES;
    
    //ボタンの円半径の設定を、画面変化に対応させる
    //        sender.layer.cornerRadius = (self.view.bounds.size.width / 2) * 1.0f;
    //            sender.layer.masksToBounds = YES;
    
    
}


//ハズレボタンの色とアクションを設定
-(void)setButtonActionAndColor:(NSString*)action color:(NSString*)colorStr tag:(NSInteger)tag
{
    UIButton *button = (UIButton*)[self.view viewWithTag:tag];
    
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
    
    NSNumber* tag1 = [NSNumber numberWithInt:1];
    NSNumber* tag2 = [NSNumber numberWithInt:2];
    NSNumber* tag3 = [NSNumber numberWithInt:3];
    NSNumber* tag4 = [NSNumber numberWithInt:4];
    NSNumber* tag5 = [NSNumber numberWithInt:5];
    
    NSMutableArray *allTag = [NSMutableArray array];
    [allTag addObject:tag1];
    [allTag addObject:tag2];
    [allTag addObject:tag3];
    [allTag addObject:tag4];
    [allTag addObject:tag5];
    
    NSString* wrongActionLabel1;
    NSString* wrongActionLabel2;
    NSString* wrongColorLabel1;
    NSString* wrongColorLabel2;
    
    
    //①まず、今回の正解のアクションと色をランダムに決める
    NSInteger correctAction = arc4random() % 5;
    NSString* correctActionStr = [allAction objectAtIndex:correctAction];
    
    NSInteger correctColor = arc4random() % 5;
    NSString* correctColorStr = [allColor objectAtIndex:correctColor];
    
    
    //②正解ボタンをボタン1〜5のどれにするかをランダムに決める
    correctButtonTag = arc4random() % 5;
    NSInteger correctButtonTagNumber = [[allTag objectAtIndex:correctButtonTag]intValue];
    
    
    //③正解ボタンのアクションと色を設定する
    [self setButtonActionAndColor:correctActionStr color:correctColorStr tag:correctButtonTagNumber];
    
    //④正解ボタンのアクションと色は、もう使わないのでarrayから削除する
    [allAction removeObjectAtIndex:correctAction];
    [allColor removeObjectAtIndex:correctColor];
    [allTag removeObjectAtIndex:correctButtonTag];
    
    
    //⑤後の説明文表示に使うので、新たにNSMutableArrayを作成する（要素の０は「正しいアクション」要素の１は「正しい色」となる）
    NSMutableArray *arrayForQuestionLabel = [NSMutableArray array];
    [arrayForQuestionLabel addObject:correctActionStr];
    [arrayForQuestionLabel addObject:correctColorStr];
    
    
    //⑥不正解ボタンのアクションと色を設定する
    for(NSInteger i=1;i<=4;i++){
        
        NSInteger wrongAction = arc4random() % [allAction count];
        NSString* wrongActionStr = [allAction objectAtIndex:wrongAction];
        
        NSInteger wrongColor = arc4random() % [allColor count];
        NSString* wrongColorStr = [allColor objectAtIndex:wrongColor];
        
        //⑥−1　不正解ボタンを1〜5のどれにするかを決める
        NSInteger wrongButtonTag = arc4random() % [allTag count];
        NSInteger wrongButtonTagNumber = [[allTag objectAtIndex:wrongButtonTag]intValue];
        
        //⑥−2　不正解ボタンのアクションと色を設定し、更に設問ラベル用に変数に格納しておく（周回によってどれにいれるか決める）
        [self setButtonActionAndColor:wrongActionStr color:wrongColorStr tag:wrongButtonTagNumber];
        
        if(i ==1){
            wrongActionLabel1 = wrongActionStr;
        }else if(i == 2){
            wrongActionLabel2 = wrongActionStr;
        }else if(i == 3){
            wrongColorLabel1 = wrongColorStr;
        }else if(i == 4){
            wrongColorLabel2 = wrongColorStr;
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
    NSMutableString *labelText2 = [[NSMutableString alloc]initWithString:@"首輪の色はたしか…\n　"];
    
    //⑦−1　設問パターンがYESの場合
    if(pattern == YES){
        
        [labelText1 appendString:correctActionStr];
        [labelText1 appendString:@"？\n　"];
        [labelText1 appendString:wrongActionLabel1];
        [labelText1 appendString:@"…？"];
        [label1 setText:labelText1];
        
        [labelText2 appendString:correctColorStr];
        [labelText2 appendString:@"色か\n　"];
        [labelText2 appendString:wrongColorLabel1];
        [labelText2 appendString:@"色だったの…"];
        [label2 setText:labelText2];
        
        
        //⑦−2　設問パターンがNOの場合
    } else if(pattern == NO){
        
        //不正解ボタンから、まずランダムで２つ選ぶ。その二つがアクション１と２になる。ランダムで選んでるので、表示順もそのまま最初のが１、２番目が２でオK
        //残りの２つを色１と２にする
        
        [labelText1 appendString:wrongActionLabel1];
        [labelText1 appendString:@"？\n　"];
        [labelText1 appendString:wrongActionLabel2];
        [labelText1 appendString:@"…？"];
        [label1 setText:labelText1];
        
        [labelText2 appendString:wrongColorLabel1];
        [labelText2 appendString:@"色か\n　"];
        [labelText2 appendString:wrongColorLabel2];
        [labelText2 appendString:@"色だったの…"];
        [label2 setText:labelText2];

    } else {
    }
}

-(void)timer:(NSTimer*)timer
{
    
    timeCount = timeCount - 0.01f;
    float second = fmodf(timeCount,60);
     self.timeStr = [NSString stringWithFormat:@"残り時間 %05.2f",second];
    
    self.timeLabel.text = self.timeStr;
}

-(void)timerStart
{
    timeCount = 60;
    if(![_timer isValid]){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
    
}


@end
