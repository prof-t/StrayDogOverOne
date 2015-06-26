//
//  AlertView.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/24.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "AlertView.h"

@interface SDAlertInfo : NSObject
@property(nonatomic,copy) void (^handler)(void);
@property(nonatomic,copy) NSString *label;

- (instancetype)initWithLabel:(NSString *)label handler:(void(^)(void))handler;

@end

@implementation SDAlertInfo

- (instancetype)initWithLabel:(NSString *)label handler:(void(^)(void))handler
{
    self = [super init];
    if (self) {
        self.label = label;
        self.handler = handler;
    }
    return self;
}

@end


@interface SDBlockAlertView : UIAlertView<UIAlertViewDelegate>
// SDAlertInfo array
@property(nonatomic,strong) NSMutableArray *alertInfoArray;


@end

@implementation SDBlockAlertView

- (void)alertView:(SDBlockAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SDAlertInfo *alertInfo = self.alertInfoArray[buttonIndex];
    alertInfo.handler();
}

@end


@interface AlertView()
// title
@property(nonatomic,copy) NSString *title;
// message
@property(nonatomic,copy) NSString *message;
// temp alert
@property(nonatomic,strong) id AlertObject;
// owner
@property(nonatomic,weak) UIViewController *owner;
// SDAlertInfo array
@property(nonatomic,strong) NSMutableArray *alertInfoArray;
@end

@implementation AlertView



/**
 初期化する
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message owner:(UIViewController *)owner
{
    self = [super init];
    if (self) {
        [self initializeWithTitle:title message:message owner:owner];
    }
    return self;
}

- (void)initializeWithTitle:(NSString *)title message:(NSString *)message owner:(UIViewController *)owner
{
    self.title = title;
    self.message = message;
    self.owner = owner;
    
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
    if (1) {
        // old
        // まだ生成できない...
    }
    else {
        // new
        
    }
}

/**
 add
 */
- (void)addLabel:(NSString *)label handler:(void (^)(void))handler
{
    SDAlertInfo * alertInfo = [[SDAlertInfo alloc] initWithLabel:label handler:handler];
   
    if (!self.alertInfoArray) {
        self.alertInfoArray = [@[] mutableCopy];
    }
    
    [self.alertInfoArray addObject:alertInfo];
    
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
    if (1) {
        // old
        // まだ生成できない...
        
    }
    else {
        // new
        
    }
}

/**
 show
 */
- (void)show
{
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
    if (1) {
        // old
        SDAlertInfo *firstAlertInfo = self.alertInfoArray[0];
        __block SDBlockAlertView *alertView = [[SDBlockAlertView alloc] initWithTitle:self.title message:self.message delegate:nil cancelButtonTitle:nil otherButtonTitles:firstAlertInfo.label, nil];
        alertView.delegate = alertView;
        alertView.alertInfoArray = self.alertInfoArray;
//        self.AlertObject = alertView;
        
        [self.alertInfoArray enumerateObjectsUsingBlock:^(SDAlertInfo *alertInfo, NSUInteger idx, BOOL *stop) {
            if (idx == 0) {
                return;
            }
            
            [alertView addButtonWithTitle:alertInfo.label];
            
        }];
        
        [alertView show];

    }
    else {
        // new
        
    }
}

-(UIAlertController *)makeAlertControllerWithTitleWithAction:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle *)style firstAction:(UIAlertAction *)firstAction secondAction:(UIAlertAction *)secondAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:*style];
    
    
//    UIAlertController *__weak weakAlert = alert;
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    return alert;
    
}

//AlertAction生成のメソッド
//-(UIAlertAction *)makeAlertActionWithTitle:(NSString *)title style:(UIAlertActionStyle *)style handler:( ? )handler
//{
//    return [UIAlertAction actionWithTitle:title style:style handler:handler];
//}

//AlertActionのイベント処理




@end
