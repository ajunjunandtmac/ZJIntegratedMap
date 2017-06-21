//
//  ZJCommonAlertControllerFactory.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/9.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJCommonAlertFactory.h"
#import "ZJCommonAlertController.h"
@interface ZJCommonAlertFactory ()
@property(nonatomic,strong)UIViewController *commonAlertController;
@end

@implementation ZJCommonAlertFactory
- (instancetype)initWithParams:(ZJCustomerAlertBuilderParams *)params
{
    self = [super init];
    if (self) {
        _commonAlertController = [[ZJCommonAlertController alloc] initWithParams:params];
    }
    return self;
}

- (UIViewController *)getAlertController
{
    return _commonAlertController;
}

@end
