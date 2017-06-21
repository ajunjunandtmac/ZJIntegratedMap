//
//  BaiduMapFactory.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduMapFactory.h"
#import "BaiduMap.h"
#import "BaiduLocationService.h"
#import "BaiduTipSearcher.h"
#import "BaiduPOISearcher.h"
#import "BaiduPOIDetailSearcher.h"
#import "BaiduDriveRouteService.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
@interface BaiduMapFactory ()

@end

@implementation BaiduMapFactory
- (instancetype)initWithAppKey:(NSString *)appKey
{
    self = [super init];
    if (self) {
        BMKMapManager *manager = [[BMKMapManager alloc] init];
        [manager start:appKey generalDelegate:nil];
    }
    return self;
}

- (id<IMapProtocol>)mapWithFrame:(CGRect)frame
{
    BaiduMap *map = [[BaiduMap alloc] initWithFrame:frame];
    return map;
}

- (id<ILocationService>)getMapLocationServiceWithDelegate:(id<ILocationServiceDelegate>)delegate
{
    BaiduLocationService *locationService = [[BaiduLocationService alloc] initWithDelegate:delegate];
    return locationService;
}

- (id<ITipSearcher>)getSearcher
{
    BaiduTipSearcher *searcher = [[BaiduTipSearcher alloc] init];
    return searcher;
}

- (id<IPOISearcher>)getPOISearcher
{
    BaiduPOISearcher *searcher = [[BaiduPOISearcher alloc] init];
    return searcher;
}

- (id<IPOIDetailSearcher>)getPOIDetailSearcher
{
    BaiduPOIDetailSearcher *searcher = [[BaiduPOIDetailSearcher alloc] init];
    return searcher;
}

/** 生产驾车路径规划功能 */
- (id<IDriveRouteService>)getDriveRouteService
{
    BaiduDriveRouteService *service = [[BaiduDriveRouteService alloc] init];
    return service;
}

/** 生产骑行路径规划功能 not implemented */
- (id<IRideRouteService>)getRideRouteService
{
    return nil;
}

/** 生产步行规划功能 not implemented */
- (id<IWalkRouteService>)getWalkRouteService
{
    return nil;
}
@end
