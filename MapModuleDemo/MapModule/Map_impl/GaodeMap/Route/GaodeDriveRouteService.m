//
//  GaodeDriveRouteService.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeDriveRouteService.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "GaodeRoutePoint.h"
@interface GaodeDriveRouteService ()<AMapSearchDelegate>
@property(nonatomic,strong)AMapSearchAPI *driveManager;
@property(nonatomic,strong)AMapDrivingRouteSearchRequest *option;
//@property(nonatomic,strong)AMapGeoPoint *startPoint;
//@property(nonatomic,strong)AMapGeoPoint *endPoint;
@property(nonatomic,weak)id<IRouteServiceDelegate>delegate;
@end

@implementation GaodeDriveRouteService
- (instancetype)init
{
    self = [super init];
    if (self) {
        _driveManager = [[AMapSearchAPI alloc] init];
        _driveManager.delegate = self;
        _option = [[AMapDrivingRouteSearchRequest alloc] init];
        _option.requireExtension = NSUnderlyingErrorKey;
        _option.strategy = 0;
    }
    return self;
}

- (void)setDelegate:(id<IRouteServiceDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint
{
    _option.origin = [AMapGeoPoint locationWithLatitude:startPoint.latitude longitude:startPoint.longitude];
    _option.destination = [AMapGeoPoint locationWithLatitude:endPoint.latitude longitude:endPoint.longitude];
}

- (void)startRouteSearching
{
    [self.driveManager AMapDrivingRouteSearch:_option];
}

#pragma mark - AMapNaviDriveManagerDelegate
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
#warning 这里只做了单条路径的规划 如果要扩展为多条规划路径，这里的代码逻辑需要改动
    AMapRoute *naviRoute = response.route;
    //获取途经点数组
    NSMutableArray *naviRoutePoints = [NSMutableArray array];
    GaodeRoutePoint *startPoint = [[GaodeRoutePoint alloc] initWithAMapGeoPoint:naviRoute.origin];
    [naviRoutePoints addObject:startPoint];
    
    for (AMapPath *path in naviRoute.paths) {
        for (AMapStep *step in path.steps) {
            NSString *polyLine = step.polyline;//format 120.738464,31.275717;120.738457,31.275486
            NSArray *points = [polyLine componentsSeparatedByString:@";"];
            for (NSString *point in points) {
                NSArray *pointComponents = [point componentsSeparatedByString:@","];
                AMapGeoPoint *geoPoint = [AMapGeoPoint locationWithLatitude:[pointComponents[1] floatValue]  longitude:[pointComponents[0] floatValue]];
                GaodeRoutePoint *wayPoint = [[GaodeRoutePoint alloc] initWithAMapGeoPoint:geoPoint];
                [naviRoutePoints addObject:wayPoint];
            }
        }
    }
    
    GaodeRoutePoint *endPoint = [[GaodeRoutePoint alloc] initWithAMapGeoPoint:naviRoute.destination];
    [naviRoutePoints addObject:endPoint];

    NSArray *routes = @[
                        @{@0:naviRoutePoints}
                        ];
    if ([_delegate respondsToSelector:@selector(onGetRoutesSuccess:)]) {
        [_delegate onGetRoutesSuccess:routes];
    }
}
@end
