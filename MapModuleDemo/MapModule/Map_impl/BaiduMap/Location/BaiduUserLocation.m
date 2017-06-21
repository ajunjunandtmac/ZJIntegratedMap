//
//  BaiduUserLocation.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/15.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduUserLocation.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
@interface BaiduUserLocation ()
@property(nonatomic,strong)BMKUserLocation *userLocation;
@end

@implementation BaiduUserLocation
- (instancetype)initWithBMKUserLocation:(BMKUserLocation *)userLocation
{
    self = [super init];
    if (self) {
        _userLocation = userLocation;
    }
    return self;
}

#pragma mark - IUserLocation
- (id)SDKOriginalUserLocation
{
    return _userLocation;
}

- (BOOL)isUpdating
{
    return _userLocation.isUpdating;
}

- (CLLocation *)location
{
    return _userLocation.location;
}

- (CLHeading *)heading
{
    return _userLocation.heading;
}

- (NSString *)title
{
    return _userLocation.title;
}

- (NSString *)subtitle
{
    return _userLocation.subtitle;
}
@end
