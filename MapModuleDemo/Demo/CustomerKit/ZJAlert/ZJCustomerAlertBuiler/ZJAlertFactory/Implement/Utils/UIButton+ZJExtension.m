//
//  UIButton+AdjustContentPosition.m
//  微博项目
//
//  Created by steven on 15-8-15.
//  Copyright (c) 2015年 terena. All rights reserved.
//

#import "UIButton+ZJExtension.h"

@implementation UIButton (ZJExtension)

- (UIButton *)adjustContentPositionWithContentInterval:(float)interval isTitleShowOnTheLeft:(BOOL)isTitleOnTheLeft
{
    if (isTitleOnTheLeft) {
        float leftCutSize = CGRectGetMaxX(self.titleLabel.frame) - CGRectGetWidth(self.imageView.frame) + interval * 0.5;
        float rightCutSize = CGRectGetWidth(self.imageView.frame) + interval * 0.5;
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, leftCutSize, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, rightCutSize)];
    }
    else
    {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, interval * 0.5)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, interval * 0.5, 0, 0)];
    }
    
    return self;
        
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    UIImage *image = [self imageWithColor:backgroundColor andHeight:10];
    [self setBackgroundImage:image forState:state];
}

- (UIImage *)imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
