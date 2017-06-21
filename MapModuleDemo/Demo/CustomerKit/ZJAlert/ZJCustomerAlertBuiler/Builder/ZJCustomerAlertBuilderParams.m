//
//  ZJCustomerAlertBuilderParams.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/9.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJCustomerAlertBuilderParams.h"

@implementation ZJCustomerAlertBuilderParams
- (instancetype)initWithContext:(UIViewController *)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (NSDictionary *)titleAttributes
{
    if (_titleAttributes) {
        return _titleAttributes;
    }
    
    return @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]};
}

- (NSDictionary *)messageAttributes
{
    if (_messageAttributes) {
        return _messageAttributes;
    }
    
    return @{NSForegroundColorAttributeName:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1.0f],NSFontAttributeName:[UIFont systemFontOfSize:13]};
}

- (NSDictionary *)cancelActionTitleAttributes
{
    if (_cancelActionTitleAttributes) {
        return _cancelActionTitleAttributes;
    }
    
    return @{NSForegroundColorAttributeName:[UIColor colorWithRed:53/255.0f green:121/255.0f blue:246/255.0f alpha:1.0f],NSFontAttributeName:[UIFont systemFontOfSize:14]};
}

- (UIColor *)cancelButtonColor
{
    if (_cancelButtonColor) {
        return _cancelButtonColor;
    }
    
    return [UIColor redColor];
}

- (NSDictionary *)confirmActionTitleAttributes
{
    if (_confirmActionTitleAttributes) {
        return _confirmActionTitleAttributes;
    }
    return @{NSForegroundColorAttributeName:[UIColor colorWithRed:53/255.0f green:121/255.0f blue:246/255.0f alpha:1.0f],NSFontAttributeName:[UIFont systemFontOfSize:14]};
}

- (UIColor *)confirmButtonColor
{
    if (_confirmButtonColor) {
        return _confirmButtonColor;
    }
    
    return [UIColor yellowColor];
}
@end
