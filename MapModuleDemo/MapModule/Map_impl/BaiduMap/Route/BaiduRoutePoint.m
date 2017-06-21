//
//  BaiduRoutePoint.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduRoutePoint.h"
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
@interface BaiduRoutePoint ()
@property(nonatomic,strong)BMKPlanNode *planNode;
@property(nonatomic,strong)BMKRouteNode *routeNode;

@end

@implementation BaiduRoutePoint
- (instancetype)initWithBMKPlanNode:(BMKPlanNode *)node
{
    self = [super init];
    if (self) {
        _planNode = node;
    }
    return self;
}

- (instancetype)initWithBMKRouteNode:(BMKRouteNode *)node
{
    self = [super init];
    if (self) {
        _routeNode = node;
    }
    return self;
}

- (CLLocationCoordinate2D)getRouteCoordinate
{
    return _planNode?_planNode.pt : _routeNode.location;
}
@end
