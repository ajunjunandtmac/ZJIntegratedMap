//
//  NSString+AutoCountLabelFrame.m
//  微博项目
//
//  Created by Apple on 15-8-19.
//  Copyright (c) 2015年 terena. All rights reserved.
//

#import "NSString+AutoCountLabelSize.h"

@implementation NSString (AutoCountLabelSize)
- (CGSize)sizeWithFontForSingleRow:(UIFont *)font
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [self sizeWithAttributes:dic];
}

- (CGSize)sizeWithFontforMultiRows:(UIFont *)font rowMaxWidth:(float)rowMaxWidth
{
     NSDictionary *dic = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:CGSizeMake(rowMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

- (BOOL)isEmptyString
{
    if ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return YES;
    }
    return NO;
}

@end
