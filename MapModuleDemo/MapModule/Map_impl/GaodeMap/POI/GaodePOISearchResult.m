//
//  BaiduPOISearchResult.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodePOISearchResult.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface GaodePOISearchResult ()
@property(nonatomic,strong)AMapPOI *poiInfo;
@end

@implementation GaodePOISearchResult
- (instancetype)initWithAMapPoiInfo:(AMapPOI *)poiInfo
{
    self = [super init];
    if (self) {
        _poiInfo = poiInfo;
    }
    return self;
}

- (NSString *)getPoiId
{
    return _poiInfo.uid;
}

- (NSString *)getName
{
    return _poiInfo.name;
}

- (NSString *)getAddress
{
    return _poiInfo.address;
}

- (CLLocationCoordinate2D)getLocation
{
    return CLLocationCoordinate2DMake(_poiInfo.location.latitude, _poiInfo.location.longitude);;
}
@end
