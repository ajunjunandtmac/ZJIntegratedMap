//
//  BaiduPOISearchResult.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPOISearchResult.h"
@class BMKPoiInfo;
@interface BaiduPOISearchResult : NSObject<IPOISearchResult>
- (instancetype)initWithBMKPoiInfo:(BMKPoiInfo *)poiInfo;
@end
