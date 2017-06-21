//
//  BaiduSearcher.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/16.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduTipSearcher.h"
#import <BaiduMapAPI_Search/BMKSearchBase.h>
#import <BaiduMapAPI_Search/BMKSuggestionSearch.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>//根据location信息反查城市名
#import "BaiduSearchTip.h"
@interface BaiduTipSearcher ()<BMKSuggestionSearchDelegate,BMKGeoCodeSearchDelegate>
@property(nonatomic,strong)BMKSuggestionSearch *searcher;
@property(nonatomic,weak)id<ITipSearcherDelegate>delegate;
@property(nonatomic,strong)BMKSuggestionSearchOption *option;
@property(nonatomic,copy)void(^reverseGeoSearchSuccess)();
@property(nonatomic,strong)BMKGeoCodeSearch *geoCodeSearcher;
@end

@implementation BaiduTipSearcher
- (instancetype)init
{
    self = [super init];
    if (self) {
        _searcher = [[BMKSuggestionSearch alloc] init];
        _searcher.delegate = self;
        _option = [[BMKSuggestionSearchOption alloc] init];
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
    _geoCodeSearcher = [[BMKGeoCodeSearch alloc] init];
    _geoCodeSearcher.delegate = self;
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint = userLocaton.location.coordinate;
    [_geoCodeSearcher reverseGeoCode:option];
    _reverseGeoSearchSuccess = success;
}

- (void)setSearchCityName:(NSString *)cityName
{
    _option.cityname = cityName;
}

- (void)setSearchKeyword:(NSString *)keyword
{
    _option.keyword = keyword;
}

- (void)startSearching
{
    [_searcher suggestionSearch:_option];
}

#pragma mark - BMKSuggestionSearchDelegate
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error
{
    //坑爹百度，results竟然用四个数组保存！！！ 不会用模型数组！小学生水平！
    NSMutableArray<BaiduSearchTip *> *results = [NSMutableArray array];
    for (int i=0; i<result.keyList.count; i++) {
        NSString *key = result.keyList[i];
        BaiduSearchTip *tip = [[BaiduSearchTip alloc] init];
        tip.name = key;
        [results addObject:tip];
    }
    
    for (int i=0; i<result.cityList.count; i++) {
        NSString *city = result.cityList[i];
        results[i].address = city;
    }
    
    for (int i=0; i<result.districtList.count; i++) {
        NSString *district = result.districtList[i];
        results[i].address = [results[i].address stringByAppendingString:district];
    }
    
    for (int i=0; i<result.ptList.count; i++) {
        CLLocationCoordinate2D location;
        [result.ptList[i] getValue:&location];
        results[i].location = location;
    }
    
    for (int i=0; i<result.poiIdList.count; i++) {
        NSString *poiId = result.poiIdList[i];
        results[i].poiId = poiId;
    }
    
    [_delegate onGetTipSearchResult:results];
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    [self setSearchCityName:result.addressDetail.city];

    if (_reverseGeoSearchSuccess) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        _reverseGeoSearchSuccess();
#pragma clang diagnostic pop
    }

    _reverseGeoSearchSuccess = nil;//主动释放block，防止循环引用
}
@end
