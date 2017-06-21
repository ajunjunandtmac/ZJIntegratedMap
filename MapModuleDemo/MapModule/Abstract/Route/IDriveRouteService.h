//
//  IDriveRouteService.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/20.
//  Copyright © 2017年 jiale. All rights reserved.
//  默认采用各个地图平台的单路径距离最短策略，如需其他策略可扩展该协议

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "IRouteServiceDelegate.h"
@protocol IDriveRouteService <NSObject>
- (void)setDelegate:(id<IRouteServiceDelegate>)delegate;
- (void)setStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint;
-(void)startRouteSearching;
@end
