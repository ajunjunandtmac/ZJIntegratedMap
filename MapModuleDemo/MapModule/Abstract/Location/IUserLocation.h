//
//  IUserLocation.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/15.
//  Copyright © 2017年 jiale. All rights reserved.
//  抽象用户信息

#import <Foundation/Foundation.h>
@class CLHeading,CLLocation;
@protocol IUserLocation <NSObject>
//SDK原生userLocation
- (id)SDKOriginalUserLocation;

/// 位置更新状态，如果正在更新位置信息，则该值为YES
- (BOOL)isUpdating;

/// 位置信息，尚未定位成功，则该值为nil
- (CLLocation *)location;

/// heading信息，尚未定位成功，则该值为nil
- (CLHeading *)heading;

/// 定位标注点要显示的标题信息
- (NSString *)title;

/// 定位标注点要显示的子标题信息.
- (NSString *)subtitle;

@end
