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

@property (weak, nonatomic) IBOutlet UIView *clearView;
@property (weak, nonatomic) IBOutlet UIImageView *clearViewImage;

@end

@implementation EasyModeViewController
{
    int correctButtonTag;
    BOOL questionPattern;
    
    //タイマー
    __weak NSTimer *_timer;
    float timeCount;
    float _secondsOfTimer;
    NSString *_timeStr;
    
    int nowScore;
    Question *questionClassOBJ;
    BOOL _correctOrWrong;
}


@synthesize timeStr;


//初期化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iPhone/iPadの画面サイズに合わせて背景画像を拡大・縮小する
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"back1.jpg"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    nowScore = 0;
    questionClassOBJ = [Question alloc];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CancelButton:(id)sender
{
    //アラートの表示（iOS8か否かで処理が分岐する）
//    if( [[UIDevice currentDevice].systemVersion floatValue] < 8) {
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {

        NSLog(@"iOS7.1以前のバージョンですね");
    
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"ゲームを終了しますか？" delegate:self cancelButtonTitle:@"ゲームを終了しない" destructiveButtonTitle:@"ゲームを終了してタイトル画面に戻る" otherButtonTitles:nil];
    [as showInView:self.view];
    
    } else {

        NSLog(@"iOS7.1以降のバージョンですね");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ゲームをやめますか？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertController *__weak weakAlert = alert;
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"やめない" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:defaultAction];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"やめる" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
            
            [_timer invalidate];//Timerを止める
            TitleScreenViewController *titleVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"TitleScreen"];//title画面に遷移する
            [self presentViewController:titleVC animated:YES completion:nil];//YESならModal,Noなら何もなし
            [_player stop];//音楽も止める
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

- (IBAction)gameStartMetod:(UIBarButtonItem*)sender
{
    sender.enabled = NO;
    self.clearView.hidden =YES;
    self.clearView.hidden =YES;
    
    //女の子の顔画像を変更
    self.girlImage.image = [UIImage imageNamed:@"girl3.jpg"];
    
    
    
    /*★☆★　動作確認用テスト★☆★*/
    //ボタンのhiddenを解除
    self.dogButton1.enabled = YES;
    self.dogButton2.enabled = YES;
    self.dogButton3.enabled = YES;
    
    //今回の設問パターン（YES/NO）を決定
    questionPattern = [self questionPattern:self.questionNumber];
    
    //設問パターンをもとに、正解ボタンと失敗ボタンを生成し、同時に設問文の表示を行う
    [self decidedQuestion:questionPattern label1:self.questionColorLabel label2:self.questionActionLabel];
    
    //音楽START！
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"カジノ4" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    [self.player play];
    
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

- (IBAction)tapButton:(UIButton*)sender
{
    
    NSLog(@"押したボタンのタグは%d",(int)sender.tag);
    NSLog(@"正解ボタンのタグは%d",correctButtonTag);
    
    [_timer invalidate];
    [self.player stop];
    
    self.clearView.hidden = NO;
    self.clearViewImage.hidden = NO;
    
    UINavigationBar *navBar = (UINavigationBar*)[self.view viewWithTag:10];
    
    
    //効果音、得点の増減、正解か不正解の値渡しを行う
    if(sender.tag == correctButtonTag + 1){
        NSLog(@"正解！！");
        NSURL *bgm1URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"correct2" ofType:@"mp3"] ];
        _playerEffect = [[AVAudioPlayer alloc]initWithContentsOfURL:bgm1URL error:nil];
        self.playerEffect.numberOfLoops = 0;
        [self.playerEffect play];
        nowScore = [questionClassOBJ evaluateScoreWithIsCorrect:timeCount remainTime:YES completion:^(NSInteger score) {
            
        }] + nowScore;
        _correctOrWrong = YES;
        self.clearViewImage.image =[UIImage imageNamed:@"girl2.jpg"];
        navBar.topItem.title = @"おめでとう!!";
        
    } else {
        NSLog(@"残念！！");
        nowScore = [questionClassOBJ evaluateScoreWithIsCorrect:timeCount remainTime:NO completion:^(NSInteger score) {
            
        }] + nowScore;
        
        NSURL *bgm2URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"d6" ofType:@"mp3"] ];
        _playerEffect = [[AVAudioPlayer alloc]initWithContentsOfURL:bgm2URL error:nil];
        self.playerEffect.numberOfLoops = 0;
        [self.playerEffect play];
        _correctOrWrong = NO;
        self.clearViewImage.image =[UIImage imageNamed:@"girl1.jpg"];
        navBar.topItem.title = @"残念!!";
    }
    
    NSString *nowScoreStr = [[NSString alloc]initWithFormat:@"総得点 %d",nowScore];
    self.totalScore.text = nowScoreStr;
    
    self.dogButton1.enabled = NO;
    self.dogButton2.enabled = NO;
    self.dogButton3.enabled = NO;
    
    
    self.gameStartButton.enabled = YES;
    
    //ボタンの円半径の設定を、画面変化に対応させる
    //        sender.layer.cornerRadius = (self.view.bounds.size.width / 2) * 1.0f;
    //            sender.layer.masksToBounds = YES;
    
    
}


//ハズレボタンの色とアクションを設定
-(void)setButtonActionAndColor:(NSString*)action color:(NSString*)colorStr tag:(int)tag
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
-(BOOL)questionPattern:(int)questionNumber
{
    BOOL pattern = arc4random()% 2;
    NSLog(@"今回の設問パターンは%d",pattern);
    
    //問題数のカウントを＋１しておく
    self.questionNumber = self.questionNumber + 1;
    NSLog(@"questionNumberは%d",questionNumber);
    
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

    
    NSMutableArray *allTag = [NSMutableArray array];
    [allTag addObject:tag1];
    [allTag addObject:tag2];
    [allTag addObject:tag3];

    
    NSString* wrongActionLabel;
    NSString* wrongColorLabel;
    
    
    //①まず、今回の正解のアクションと色をランダムに決める
    int correctAction = arc4random() % 5;
    NSString* correctActionStr = [allAction objectAtIndex:correctAction];
    
    int correctColor = arc4random() % 5;
    NSString* correctColorStr = [allColor objectAtIndex:correctColor];
    
    
    //②正解ボタンをボタン1〜３のどれにするかをランダムに決める
    correctButtonTag = arc4random() % 3;
    int correctButtonTagNumber = [[allTag objectAtIndex:correctButtonTag]intValue];
    
    
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
    for(int i=1;i<=2;i++){
        
        int wrongAction = arc4random() % [allAction count];
        NSString* wrongActionStr = [allAction objectAtIndex:wrongAction];
        
        int wrongColor = arc4random() % [allColor count];
        NSString* wrongColorStr = [allColor objectAtIndex:wrongColor];
        
        NSLog(@"wrongAction %d",wrongAction);
        //    NSLog(@"correctColor %d",correctColor);
        
        //⑥−1　不正解ボタンを1〜３のどれにするかを決める
        int wrongButtonTag = arc4random() % [allTag count];
        int wrongButtonTagNumber = [[allTag objectAtIndex:wrongButtonTag]intValue];
        //    NSLog(@"correctButtonTag %d",correctButtonTag);
        
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
        
        NSLog(@"不正解ボタンの色：%@　アクション：%@　tag：%d",wrongColorStr,wrongActionStr,wrongButtonTagNumber);
        
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
        
        
    } else {
        NSLog(@"ランダムメソッドが何かおかしいよ");
    }
    
    
}

-(void)timer:(NSTimer*)timer
{
    
    timeCount = timeCount - 0.01f;
    float second = fmodf(timeCount,60);
    _timeStr = [NSString stringWithFormat:@"残り時間 %05.2f",second];
    
//    NSLog(@"timerメソッドの中。今のtimeは%f",second);
    
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
