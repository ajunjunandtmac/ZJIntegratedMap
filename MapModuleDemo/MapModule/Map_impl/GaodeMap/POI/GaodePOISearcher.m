//
//  BaiduPOISearcher.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodePOISearcher.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "GaodePOISearchResult.h"
@interface GaodePOISearcher ()<AMapSearchDelegate>
@property(nonatomic,strong)AMapSearchAPI *searcher;
@property(nonatomic,strong)AMapPOIAroundSearchRequest *option;
@property(nonatomic,weak)id<IPOISearcherDelegate>delegate;
@end

@implementation GaodePOISearcher
- (instancetype)init
{
    self = [super init];
    if (self) {
        _searcher = [[AMapSearchAPI alloc] init];
        _searcher.delegate = self;
        _option = [[AMapPOIAroundSearchRequest alloc] init];
    }
    return self;
}

- (void)setDelegate:(id<IPOISearcherDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setKeyword:(NSString *)keyword
{
    _option.keywords = keyword;
}

- (void)setLocation:(id<IUserLocation>)userLocaton
{
    CLLocationCoordinate2D coordinate = userLocaton.location.coordinate;
    _option.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

- (void)setPageIndex:(int)pageIndex
{
    _option.page = pageIndex;
}

- (void)startSearching
{
    [_searcher AMapPOIAroundSearch:_option];
}

#pragma mark - BMKPoiSearchDelegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    NSArray *poiInfos = response.pois;
    NSMutableArray *results = [NSMutableArray array];
    for (AMapPOI *info in poiInfos) {
        GaodePOISearchResult *result = [[GaodePOISearchResult alloc] initWithAMapPoiInfo:info];
        [results addObject:result];
    }
    [_delegate onGetPOISearchResults:results];
}
@end
