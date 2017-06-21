//
//  BaiduPOISearcher.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduPOISearcher.h"
#import <BaiduMapAPI_Search/BMKSearchBase.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import "BaiduPOISearchResult.h"
@interface BaiduPOISearcher ()<BMKPoiSearchDelegate>
@property(nonatomic,strong)BMKPoiSearch *searcher;
@property(nonatomic,strong)BMKNearbySearchOption *option;
@property(nonatomic,weak)id<IPOISearcherDelegate>delegate;
@end

@implementation BaiduPOISearcher
- (instancetype)init
{
    self = [super init];
    if (self) {
        _searcher = [[BMKPoiSearch alloc] init];
        _searcher.delegate = self;
        _option = [[BMKNearbySearchOption alloc] init];
    }
    return self;
}

- (void)setDelegate:(id<IPOISearcherDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setKeyword:(NSString *)keyword
{
    _option.keyword = keyword;
}

- (void)setLocation:(id<IUserLocation>)userLocaton
{
    _option.location = userLocaton.location.coordinate;
}

- (void)setPageIndex:(int)pageIndex
{
    _option.pageIndex = pageIndex;
}

- (void)startSearching
{
    [_searcher poiSearchNearBy:_option];
}

#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    NSArray *poiInfos = poiResult.poiInfoList;
    NSMutableArray *results = [NSMutableArray array];
    for (BMKPoiInfo *info in poiResult.poiInfoList) {
        BaiduPOISearchResult *result = [[BaiduPOISearchResult alloc] initWithBMKPoiInfo:info];
        [results addObject:result];
    }
    [_delegate onGetPOISearchResults:results];
}
@end
