//
//  IPOISearchResult.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPOISearchResult <NSObject>
- (NSString *)getPoiId;
- (NSString *)getName;
- (NSString *)getAddress;
- (CLLocationCoordinate2D)getLocation;
@end
