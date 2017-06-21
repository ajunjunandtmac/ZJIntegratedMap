//
//  BaiduPOIDetailSearcher.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduPOIDetailSearcher.h"
#import <BaiduMapAPI_Search/BMKSearchBase.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import "BaiduPOIDetailSearchResult.h"
@interface BaiduPOIDetailSearcher ()<BMKPoiSearchDelegate>
@property(nonatomic,strong)BMKPoiSearch *searcher;
@property(nonatomic,strong)BMKPoiDetailSearchOption *option;
@property(nonatomic,weak)id<IPOIDetailSearcherDelegate>delegate;
@end

@implementation BaiduPOIDetailSearcher
- (instancetype)init
{
    self = [super init];
    if (self) {
        _searcher = [[BMKPoiSearch alloc] init];
        _searcher.delegate = self;
        _option = [[BMKPoiDetailSearchOption alloc] init];
    }
    return self;
}

- (void)setDelegate:(id<IPOIDetailSearcherDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setPoiID:(NSString *)poiID
{
    _option.poiUid = poiID;
}

- (void)startSearching
{
    [_searcher poiDetailSearch:_option];
}

- (void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    BaiduPOIDetailSearchResult *result = [[BaiduPOIDetailSearchResult alloc] initWithBMKPoiDetailResult:poiDetailResult];
    if ([_delegate respondsToSelector:@selector(onGetPOIDetailSearchResult:)]) {
        [_delegate onGetPOIDetailSearchResult:result];
    }
}
@end
