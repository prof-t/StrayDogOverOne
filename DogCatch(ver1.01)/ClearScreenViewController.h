//
//  ClearScreenViewController.h
//  DogCatch(ver1.01)
//
//  Created by RYO on 2015/04/06.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClearScreenViewController : UIViewController
{
    int _animeIdx;
    UIImageView* _imageView;
}

@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property BOOL correctOrWrong;

@end
