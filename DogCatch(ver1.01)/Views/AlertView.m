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
    if (buttonIndex < 0) {
        return;
    }
    
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
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // old
        // まだ生成できない...
    }
    else {
        // new
        self.AlertObject = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
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
}

/**
 show
 */
- (void)show
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // old
        SDAlertInfo *firstAlertInfo = self.alertInfoArray[0];
        __block SDBlockAlertView *alertView = [[SDBlockAlertView alloc] initWithTitle:self.title message:self.message delegate:nil cancelButtonTitle:nil otherButtonTitles:firstAlertInfo.label, nil];
        alertView.delegate = alertView;
        alertView.alertInfoArray = self.alertInfoArray;
        self.AlertObject = alertView;
        
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
        UIAlertController *ac = (UIAlertController*)self.AlertObject;
        [self.alertInfoArray enumerateObjectsUsingBlock:^(SDAlertInfo *alertInfo, NSUInteger idx, BOOL *stop) {
            
            UIAlertAction *aAction = [UIAlertAction actionWithTitle:alertInfo.label style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                alertInfo.handler();
            }];
            [ac addAction:aAction];
        }];
        
        [self.owner presentViewController:ac animated:YES completion:nil];
        
    }
}

-(void)dismiss
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        
        // old
        UIAlertView *av = (UIAlertView *)self.AlertObject;
        [av dismissWithClickedButtonIndex:-1 animated:YES];
        
    } else {
        
        // new
        UIAlertController *ac = (UIAlertController *)self.AlertObject;
        [ac dismissViewControllerAnimated:YES completion:NULL];
    }
}


@end
