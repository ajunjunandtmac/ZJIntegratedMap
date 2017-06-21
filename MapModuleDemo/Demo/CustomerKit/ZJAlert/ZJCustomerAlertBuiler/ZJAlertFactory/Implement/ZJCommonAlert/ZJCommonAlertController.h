//
//  ZJCommonAlertController.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/12.
//  Copyright © 2017年 jiale. All rights reserved.
//  具体的alertController

#import <UIKit/UIKit.h>
#import "ZJAlertFactoryProtocol.h"

@interface ZJCommonAlertController : UIViewController
- (instancetype)initWithParams:(ZJCustomerAlertBuilderParams *)params;
@end
