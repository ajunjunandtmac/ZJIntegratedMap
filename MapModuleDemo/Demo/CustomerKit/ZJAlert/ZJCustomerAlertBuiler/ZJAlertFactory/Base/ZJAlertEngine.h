//
//  ZJAlertEngine.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/9.
//  Copyright © 2017年 jiale. All rights reserved.
//  生产工厂的简单工厂

#import <Foundation/Foundation.h>
#import "ZJAlertFactoryProtocol.h"
typedef NS_ENUM(NSUInteger,ZJAlertControllerFactoryType){
    ZJAlertFactoryTypeCommon,
    ZJAlertFactoryTypeActionSheet
};
@interface ZJAlertEngine : NSObject
+ (instancetype)engine;
- (id<ZJAlertFactoryProtocol>)alertControllerFactoryWithType:(ZJAlertControllerFactoryType)type params:(ZJCustomerAlertBuilderParams *)params;
@end
