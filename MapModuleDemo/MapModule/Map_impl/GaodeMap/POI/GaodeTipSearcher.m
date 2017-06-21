//
//  BaiduSearcher.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/16.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeTipSearcher.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "GaodeSearchTip.h"
@interface GaodeTipSearcher ()<AMapSearchDelegate>
@property(nonatomic,strong)AMapSearchAPI *searcher;
@property(nonatomic,weak)id<ITipSearcherDelegate>delegate;
@property(nonatomic,strong)AMapInputTipsSearchRequest *option;
@property(nonatomic,copy)void(^reverseGeoSearchSuccess)();

/** 获取地址描述数据页面介绍地理反编码查询 */
@property(nonatomic,strong)AMapSearchAPI *geoCodeSearcher;
@end

@implementation GaodeTipSearcher
- (instancetype)init
{
    self = [super init];
    if (self) {
        _searcher = [[AMapSearchAPI alloc] init];
        _searcher.delegate = self;
        _option = [[AMapInputTipsSearchRequest alloc] init];
    }
    return self;
}
- (void)setDelegate:(id<ITipSearcherDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setLocation:(id<IUserLocation>)userLocaton reverseGeoSearchSuccess:(void (^)())success
{
    //还是得用全局变量强引用
    _geoCodeSearcher = [[AMapSearchAPI alloc] init];
    _geoCodeSearcher.delegate = self;
    AMapReGeocodeSearchRequest *option = [[AMapReGeocodeSearchRequest alloc] init];
    CLLocationCoordinate2D coordinate = userLocaton.location.coordinate;
    option.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    option.requireExtension = NO;
    [_geoCodeSearcher AMapReGoecodeSearch:option];
    _reverseGeoSearchSuccess = success;
}

- (void)setSearchCityName:(NSString *)cityName
{
    _option.city = cityName;
}

- (void)setSearchKeyword:(NSString *)keyword
{
    _option.keywords = keyword;
}

- (void)startSearching
{
    [_searcher AMapInputTipsSearch:_option];
}

#pragma mark - AMapInputTipsSearchDelegate
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    NSMutableArray *results = [NSMutableArray array];
    for (AMapTip *tip in response.tips) {
        GaodeSearchTip *customerTip = [[GaodeSearchTip alloc] initWithAMapTip:tip];
        [results addObject:customerTip];
    }
    [_delegate onGetTipSearchResult:results];
}

#pragma mark - AMapGeoCodeSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    //根据用户当前位置反编码出城市名再进行自动联想查询
    [self setSearchCityName:response.regeocode.addressComponent.city];

    if (_reverseGeoSearchSuccess) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        _reverseGeoSearchSuccess();
#pragma clang diagnostic pop
    }

    _reverseGeoSearchSuccess = nil;//主动释放block，防止循环引用
}
@end
