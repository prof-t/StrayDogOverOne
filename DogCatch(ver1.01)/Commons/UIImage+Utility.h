//
//  UIImage+Utility.h
//  StrayDogOverOne
//
//  Created by RYO on 2015/06/25.
//  Copyright (c) 2015年 RYO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

/**
imageをPNG形式でDocumentsフォルダに保存する
@param fileName Imageのファイル名（拡張子なし）
@return　保存に成功したらYES、それ以外はNOを返す
*/
-(BOOL)saveToPNGImageWithFileName:(NSString *)fileName;

@end
