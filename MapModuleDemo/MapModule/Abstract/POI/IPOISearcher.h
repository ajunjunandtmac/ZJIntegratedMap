//
//  IPOISearcher.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//  POI检索抽象类

#import <Foundation/Foundation.h>
#import "IUserLocation.h"
#import "IPOISearcherDelegate.h"
@protocol IPOISearcher <NSObject>
- (void)setDelegate:(id<IPOISearcherDelegate>)delegate;
/** 传递用户定位 */
- (void)setLocation:(id<IUserLocation>)userLocaton;
- (void)setKeyword:(NSString *)keyword;
/** 设置搜索第几页 */
- (void)setPageIndex:(int)pageIndex;
- (void)startSearching;
@end
