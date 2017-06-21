//
//  ZJAlertComponentFrameTool.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/12.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZJCustomerAlertBuilderParams.h"
@interface ZJAlertComponentFrameTool : NSObject
- (CGFloat)countAlertHeightWithAlertWidth:(CGFloat)width params:(ZJCustomerAlertBuilderParams *)params;
@property(nonatomic,strong)ZJCustomerAlertBuilderParams *params;
@property(nonatomic,assign)CGRect backVIewRect;
@property(nonatomic,assign)CGRect titleRect;
@property(nonatomic,assign)CGRect messageRect;
@property(nonatomic,assign)CGRect textFieldRect;
@property(nonatomic,assign)CGRect cancelButtonRect;
@property(nonatomic,assign)CGRect confirmButtonRect;
@property(nonatomic,assign)CGRect forkRegion;
@end
