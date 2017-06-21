//
//  IPoiDetailSearchResult.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//  POI详情检索的抽象类

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol IPoiDetailSearchResult <NSObject>
- (NSString *)getUid;
- (NSString *)getName;
- (NSString *)address;
- (CLLocationCoordinate2D)getLocation;
- (NSString *)type;//兴趣点类型
- (CLLocationDistance)getDistanceFromUserLocation;
@property(nonatomic,assign)CLLocationCoordinate2D userLocation;
@end
