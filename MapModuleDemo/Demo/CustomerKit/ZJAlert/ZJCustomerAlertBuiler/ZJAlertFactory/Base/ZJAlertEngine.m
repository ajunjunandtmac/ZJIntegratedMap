//
//  ZJAlertEngine.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/9.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJAlertEngine.h"
#import "ZJCommonAlertFactory.h"
@implementation ZJAlertEngine
+ (instancetype)engine
{
    return [[self alloc] init];
}

- (id<ZJAlertFactoryProtocol>)alertControllerFactoryWithType:(ZJAlertControllerFactoryType)type params:(ZJCustomerAlertBuilderParams *)params
{
    id<ZJAlertFactoryProtocol>factory;
    switch (type) {
        case ZJAlertFactoryTypeCommon:
            factory = [[ZJCommonAlertFactory alloc] initWithParams:params];
            break;
            
        default:
            break;
    }
    return factory;
}
@end
