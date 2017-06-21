//
//  IMapFactoryProtocol.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//  生产mapView的抽象工厂

#import <Foundation/Foundation.h>
#import "IMapProtocol.h"
#import "ILocationService.h"
#import "ITipSearcher.h"
#import "IPOISearcher.h"
#import "IPOIDetailSearcher.h"
#import "IDriveRouteService.h"
#import "IRideRouteService.h"
#import "IWalkRouteService.h"
@protocol IMapFactoryProtocol <NSObject>
/** 实例化地图工厂，用于绑定地图SDK的APPkey  */
- (instancetype)initWithAppKey:(NSString *)appKey;

/** 生产mapView工厂 */
- (id<IMapProtocol>)mapWithFrame:(CGRect)frame;

/** 生产定位功能 */
- (id<ILocationService>)getMapLocationServiceWithDelegate:(id<ILocationServiceDelegate>)delegate;

/** 生产在线查询(自动联想)功能 */
- (id<ITipSearcher>)getSearcher;

/** 生产POISearch功能 */
- (id<IPOISearcher>)getPOISearcher;

/** 生产POISearch功能 */
- (id<IPOIDetailSearcher>)getPOIDetailSearcher;

/** 生产驾车路径规划功能 */
- (id<IDriveRouteService>)getDriveRouteService;

/** 生产骑行路径规划功能 */
- (id<IRideRouteService>)getRideRouteService;

/** 生产步行规划功能 */
- (id<IWalkRouteService>)getWalkRouteService;
@end
