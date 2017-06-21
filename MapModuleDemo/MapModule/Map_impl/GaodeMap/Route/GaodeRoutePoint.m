//
//  GaodeRoutePoints.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeRoutePoint.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface GaodeRoutePoint ()
@property(nonatomic,strong)AMapGeoPoint *aMapGeoPoint;
@end

@implementation GaodeRoutePoint
- (instancetype)initWithAMapGeoPoint:(AMapGeoPoint *)point
{
    self = [super init];
    if (self) {
        _aMapGeoPoint = point;
    }
    return self;
}

- (CLLocationCoordinate2D)getRouteCoordinate
{
    return CLLocationCoordinate2DMake(_aMapGeoPoint.latitude, _aMapGeoPoint.longitude);
}

@end
