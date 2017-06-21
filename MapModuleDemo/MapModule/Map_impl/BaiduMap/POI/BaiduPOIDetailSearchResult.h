//
//  BaiduPOIDetailSearchResult.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPoiDetailSearchResult.h"
@class BMKPoiDetailResult;
@interface BaiduPOIDetailSearchResult : NSObject<IPoiDetailSearchResult>
- (instancetype)initWithBMKPoiDetailResult:(BMKPoiDetailResult *)result;
@property(nonatomic,assign)CLLocationCoordinate2D userLocation;
@end
