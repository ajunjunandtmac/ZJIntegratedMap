//
//  BaiduDriveRouteService.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//  百度比较坑，不同策略的路径规划依然是用的SearchKit

#import "BaiduDriveRouteService.h"
#import <BaiduMapAPI_Search/BMKSearchBase.h>
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import "BaiduRoutePoint.h"
@interface BaiduDriveRouteService ()<BMKRouteSearchDelegate>
@property(nonatomic,strong)BMKRouteSearch *routeSearcher;
@property(nonatomic,strong)BMKDrivingRoutePlanOption *option;
@property(nonatomic,weak)id<IRouteServiceDelegate>delegate;

@end

@implementation BaiduDriveRouteService
- (instancetype)init
{
    self = [super init];
    if (self) {
        _routeSearcher = [[BMKRouteSearch alloc] init];
        _routeSearcher.delegate = self;
        _option = [[BMKDrivingRoutePlanOption alloc] init];
        _option.drivingPolicy = BMK_DRIVING_DIS_FIRST;
    }
    return self;
}

- (void)setDelegate:(id<IRouteServiceDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint
{
    BMKPlanNode *startNode = [[BMKPlanNode alloc] init];
    startNode.pt = startPoint;
    BMKPlanNode *terminalNode = [[BMKPlanNode alloc] init];
    terminalNode.pt = endPoint;
    _option.from = startNode;
    _option.to = terminalNode;
}

- (void)startRouteSearching
{
    [_routeSearcher drivingSearch:_option];
}

#pragma mark - BMKRouteSearchDelegate
- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSMutableArray *routes = [NSMutableArray array];
    if (error == BMK_SEARCH_NO_ERROR) {
        for (int i=0; i<result.routes.count; i++) {
            NSMutableArray *route = [NSMutableArray array];
            BMKDrivingRouteLine *line = result.routes[i];
            BaiduRoutePoint *point = [[BaiduRoutePoint alloc] initWithBMKRouteNode:line.starting];
            [route addObject:point];
            
            for (BMKDrivingStep *step in line.steps) {
                BaiduRoutePoint *point = [[BaiduRoutePoint alloc] initWithBMKRouteNode:step.entrace];
                [route addObject:point];
                point = [[BaiduRoutePoint alloc] initWithBMKRouteNode:step.exit];
                [route addObject:point];
            }
            
            point = [[BaiduRoutePoint alloc] initWithBMKRouteNode:line.terminal];
            [route addObject:point];
            [routes addObject:@{@(i):route}];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(onGetRoutesSuccess:)]) {
        [_delegate onGetRoutesSuccess:routes];
    }
}
@end
