//
//  ISearchTip.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//  tipSearch结果的抽象类

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol ISearchTip <NSObject>
- (NSString *)getPoiId;
- (NSString *)getName;
- (NSString *)getAddress;
- (CLLocationCoordinate2D)getLocation;
@end
