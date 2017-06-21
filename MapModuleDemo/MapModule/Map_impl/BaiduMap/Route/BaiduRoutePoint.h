//
//  BaiduRoutePoint.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INaviRoutePoint.h"
@class BMKPlanNode;
@class BMKRouteNode;
@interface BaiduRoutePoint : NSObject<INaviRoutePoint>
/** 转换中途点planNode对象 -> BaiduRoutePoint */
- (instancetype)initWithBMKPlanNode:(BMKPlanNode *)node;

/** 转换起点/终点routeNode -> BaiduRoutePoint */
- (instancetype)initWithBMKRouteNode:(BMKRouteNode *)node;
@end
