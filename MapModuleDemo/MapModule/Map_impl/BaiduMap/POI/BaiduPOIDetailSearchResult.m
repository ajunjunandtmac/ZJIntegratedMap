//
//  BaiduPOIDetailSearchResult.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduPOIDetailSearchResult.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#include <BaiduMapAPI_Utils/BMKGeometry.h> //用于计算距离的头文件 坑爹百度也不说
@interface BaiduPOIDetailSearchResult ()
@property(nonatomic,strong)BMKPoiDetailResult *result;
@end

@implementation BaiduPOIDetailSearchResult
- (instancetype)initWithBMKPoiDetailResult:(BMKPoiDetailResult *)result
{
    self = [super init];
    if (self) {
        _result = result;
    }
    return self;
}

- (NSString *)getUid
{
    return _result.uid;
}

- (NSString *)getName
{
    return _result.name;
}

- (NSString *)address
{
    return _result.address;
}

- (CLLocationCoordinate2D)getLocation
{
    return _result.pt;
}

- (NSString *)type//兴趣点类型
{
    return _result.type;
}

- (CLLocationDistance)getDistanceFromUserLocation
{
    BMKMapPoint point1 = BMKMapPointForCoordinate(self.getLocation);
    BMKMapPoint point2 = BMKMapPointForCoordinate(self.userLocation);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return distance;
}
@end
