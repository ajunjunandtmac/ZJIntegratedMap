//
//  NSString+AutoCountLabelFrame.h
//  微博项目
//
//  Created by Apple on 15-8-19.
//  Copyright (c) 2015年 terena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (AutoCountLabelSize)
/** 返回单行size */
-(CGSize)sizeWithFontForSingleRow:(UIFont *)font;

/** 返回多行size */
-(CGSize)sizeWithFontforMultiRows:(UIFont *)font rowMaxWidth:(float)rowMaxWidth;

- (BOOL)isEmptyString;
@end
