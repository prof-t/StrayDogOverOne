//
//  UIImage+Utility.m
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/25.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

-(BOOL)saveToPNGImageWithFileName:(NSString *)fileName{
    
    //imageをNSDataに変換
    NSData *data = UIImagePNGRepresentation(self);
   
    //imageのパスを生成
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.png" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],fileName];

    return [data writeToFile:filePath atomically:YES];
}

@end
