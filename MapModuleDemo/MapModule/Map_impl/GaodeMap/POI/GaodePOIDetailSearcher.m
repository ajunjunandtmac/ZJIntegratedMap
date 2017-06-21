//
//  BaiduPOIDetailSearcher.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodePOIDetailSearcher.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "GaodePOIDetailSearchResult.h"
@interface GaodePOIDetailSearcher ()<AMapSearchDelegate>
@property(nonatomic,strong)AMapSearchAPI *searcher;
@property(nonatomic,strong)AMapPOIIDSearchRequest *option;
@property(nonatomic,weak)id<IPOIDetailSearcherDelegate>delegate;
@end

@implementation GaodePOIDetailSearcher
- (instancetype)init
{
    self = [super init];
    if (self) {
        _searcher = [[AMapSearchAPI alloc] init];
        _searcher.delegate = self;
        _option = [[AMapPOIIDSearchRequest alloc] init];
        _option.requireExtension = YES;
    }
    return self;
}

- (void)setDelegate:(id<IPOIDetailSearcherDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setPoiID:(NSString *)poiID
{
    _option.uid = poiID;
}

- (void)startSearching
{
    [_searcher AMapPOIIDSearch:_option];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    GaodePOIDetailSearchResult *result = [[GaodePOIDetailSearchResult alloc] initWithAMapPOIIDSearchResponse:response.pois[0]];
    if ([_delegate respondsToSelector:@selector(onGetPOIDetailSearchResult:)]) {
        [_delegate onGetPOIDetailSearchResult:result];
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    
}
@end
