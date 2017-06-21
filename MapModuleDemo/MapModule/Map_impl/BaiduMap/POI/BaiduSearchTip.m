//
//  BaiduSearchTip.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduSearchTip.h"

@implementation BaiduSearchTip
- (NSString *)getPoiId
{
    return _poiId;
}

- (NSString *)getName
{
    return _name;
}

- (NSString *)getAddress
{
    return _address;
}

- (CLLocationCoordinate2D)getLocation
{
    return _location;
}
@end
