//
//  BaiduUserLocation.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/15.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeUserLocation.h"
#import <AMapLocationKit/AMapLocationKit.h>
@interface GaodeUserLocation ()
@property(nonatomic,strong)CLLocation *userLocation;
@end

@implementation GaodeUserLocation
- (instancetype)initWithCLLocation:(CLLocation *)userLocation
{
    self = [super init];
    if (self) {
        _userLocation = userLocation;
    }
    return self;
}

#pragma mark - IUserLocation
//- (id)SDKOriginalUserLocation
//{
//    return _userLocation;
//}

//- (BOOL)isUpdating
//{
//    return _userLocation.isUpdating;
//}
//
- (CLLocation *)location
{
    return _userLocation;
}
//
//- (CLHeading *)heading
//{
//    return _userLocation.heading;
//}
//
//- (NSString *)title
//{
//    return _userLocation.title;
//}
//
//- (NSString *)subtitle
//{
//    return _userLocation.subtitle;
//}
@end
