//
//  BaiduUserLocation.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/15.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserLocation.h"
@class BMKUserLocation;
@interface BaiduUserLocation : NSObject<IUserLocation>
- (instancetype)initWithBMKUserLocation:(BMKUserLocation *)userLocation;
@end
