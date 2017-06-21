//
//  BaiduPOIDetailSearchResult.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPoiDetailSearchResult.h"
@class AMapPOI;
@interface GaodePOIDetailSearchResult : NSObject<IPoiDetailSearchResult>
- (instancetype)initWithAMapPOIIDSearchResponse:(AMapPOI *)result;
@property(nonatomic,assign)CLLocationCoordinate2D userLocation;
@end
