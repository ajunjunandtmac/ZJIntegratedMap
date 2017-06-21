//
//  BaiduLocationService.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/15.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduLocationService.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>//引入location相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import "BaiduUserLocation.h"
@interface BaiduLocationService ()<BMKLocationServiceDelegate>
@property(nonatomic,weak)id<ILocationServiceDelegate>delegate;
@property(nonatomic,strong)BMKLocationService *locationManager;
@end

@implementation BaiduLocationService
- (instancetype)initWithDelegate:(id<ILocationServiceDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _locationManager = [[BMKLocationService alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 200;
    }
    return self;
}

- (void)startLocation
{
    [_locationManager startUserLocationService];
}

- (void)stopLocation
{
    [_locationManager startUserLocationService];
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    /**
     *  百度地图在定位成功后还需要mapview调用updateLocationData去刷新位置，高德自动刷新
     *  此处收到百度地图地位回调后要先把BMKUserLocation转为id<IUserLocation>
     */
    BaiduUserLocation *BDUserLocation = [[BaiduUserLocation alloc] initWithBMKUserLocation:userLocation];
    [_delegate didUpdateUserLocation:BDUserLocation];
    [self stopLocation];
    
}
@end
