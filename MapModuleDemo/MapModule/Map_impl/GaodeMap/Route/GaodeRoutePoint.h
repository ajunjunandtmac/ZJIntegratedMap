//
//  GaodeRoutePoints.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INaviRoutePoint.h"
@class AMapGeoPoint;
@interface GaodeRoutePoint : NSObject<INaviRoutePoint>
- (instancetype)initWithAMapGeoPoint:(AMapGeoPoint *)point;
@end
