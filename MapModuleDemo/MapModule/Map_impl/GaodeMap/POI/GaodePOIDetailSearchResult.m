//
//  BaiduPOIDetailSearchResult.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodePOIDetailSearchResult.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAGeometry.h>
@interface GaodePOIDetailSearchResult ()
@property(nonatomic,strong)AMapPOI *result;
@end

@implementation GaodePOIDetailSearchResult
- (instancetype)initWithAMapPOIIDSearchResponse:(AMapPOI *)result
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
    return CLLocationCoordinate2DMake(_result.location.latitude, _result.location.longitude);
}

- (NSString *)type//兴趣点类型
{
    return _result.type;
}

- (CLLocationDistance)getDistanceFromUserLocation
{
    MAMapPoint point1 = MAMapPointForCoordinate(self.getLocation);
    MAMapPoint point2 = MAMapPointForCoordinate(self.userLocation);
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    return distance;
}
@end
