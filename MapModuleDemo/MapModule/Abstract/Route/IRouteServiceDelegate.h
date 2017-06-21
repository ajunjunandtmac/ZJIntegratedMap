//
//  IRouteServiceDelegate.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INaviRoutePoint.h"
@protocol IRouteServiceDelegate <NSObject>


/**
 路径规划成果后的回调

 @param routes 规划路线数组
 数组元素类型为NSDictionary<NSNumber *,NSArray<id<INaviRoutePoint>> *>*> *
 序号为key，线路点数组为value
 */
- (void)onGetRoutesSuccess:(NSArray<NSDictionary<NSNumber *,NSArray<id<INaviRoutePoint>> *>*> *)routes;
@end
