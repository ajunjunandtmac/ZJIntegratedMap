//
//  GaodeMapFactory.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeMapFactory.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "GaodeMap.h"
#import "GaodeLocationService.h"
#import "GaodeTipSearcher.h"
#import "GaodePOISearcher.h"
#import "GaodePOIDetailSearcher.h"
#import "GaodeDriveRouteService.h"
@implementation GaodeMapFactory
- (instancetype)initWithAppKey:(NSString *)appKey
{
    self = [super init];
    if (self) {
        [AMapServices sharedServices].apiKey = appKey;
        [AMapServices sharedServices].enableHTTPS = YES;
    }
    return self;
}

- (id<IMapProtocol>)mapWithFrame:(CGRect)frame
{
    GaodeMap *map = [[GaodeMap alloc] initWithFrame:frame];
    return map;
}

- (id<ILocationService>)getMapLocationServiceWithDelegate:(id<ILocationServiceDelegate>)delegate
{
    GaodeLocationService *locationService = [[GaodeLocationService alloc] initWithDelegate:delegate];
    return locationService;
}

/** 生产在线查询(自动联想)功能 */
- (id<ITipSearcher>)getSearcher
{
    GaodeTipSearcher *searcher = [[GaodeTipSearcher alloc] init];
    return searcher;
}

/** 生产POISearch功能 */
- (id<IPOISearcher>)getPOISearcher
{
    GaodePOISearcher *searcher = [[GaodePOISearcher alloc] init];
    return searcher;
}

/** 生产POISearch功能 */
- (id<IPOIDetailSearcher>)getPOIDetailSearcher
{
    GaodePOIDetailSearcher *searcher = [[GaodePOIDetailSearcher alloc] init];
    return searcher;
}

/** 生产驾车路径规划功能 */
- (id<IDriveRouteService>)getDriveRouteService
{
    GaodeDriveRouteService *service = [[GaodeDriveRouteService alloc] init];
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
