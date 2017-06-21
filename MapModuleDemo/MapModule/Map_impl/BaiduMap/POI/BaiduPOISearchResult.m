//
//  BaiduPOISearchResult.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduPOISearchResult.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
@interface BaiduPOISearchResult ()
@property(nonatomic,strong)BMKPoiInfo *poiInfo;
@end

@implementation BaiduPOISearchResult
- (instancetype)initWithBMKPoiInfo:(BMKPoiInfo *)poiInfo
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
    return _poiInfo.pt;
}
@end
