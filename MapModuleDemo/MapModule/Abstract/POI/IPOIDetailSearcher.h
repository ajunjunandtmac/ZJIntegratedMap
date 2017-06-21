//
//  IPOIDetailSearcher.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//  POI详情检索抽象类

#import <Foundation/Foundation.h>
#import "IPOIDetailSearcherDelegate.h"
@protocol IPOIDetailSearcher <NSObject>
- (void)setDelegate:(id<IPOIDetailSearcherDelegate>)delegate;
- (void)setPoiID:(NSString *)poiID;
- (void)startSearching;
@end
