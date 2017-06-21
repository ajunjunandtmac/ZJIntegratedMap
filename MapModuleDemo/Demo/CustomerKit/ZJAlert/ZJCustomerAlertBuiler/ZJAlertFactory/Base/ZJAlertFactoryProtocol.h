//
//  ZJAlertFactoryProtocol.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/9.
//  Copyright © 2017年 jiale. All rights reserved.
//  抽象工厂

#import <Foundation/Foundation.h>
#import "ZJCustomerAlertBuilderParams.h"
@protocol ZJAlertFactoryProtocol <NSObject>
/** 工厂初始化方法 */
- (instancetype)initWithParams:(ZJCustomerAlertBuilderParams *)params;

/** 生产alert */
- (UIViewController *)getAlertController;
@end
