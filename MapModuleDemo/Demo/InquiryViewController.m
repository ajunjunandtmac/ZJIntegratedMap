//
//  InquiryViewController.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/16.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "InquiryViewController.h"
#import "ZJSearchBar.h"
#import <QMUIKit/QMUIKit.h>
#import "QDCommonUI.h"
#import "QDUIHelper.h"
#import "QDThemeManager.h"
#import "ITipSearcher.h"
#import "ITipSearcherDelegate.h"
#import "IPOISearcher.h"
#import "IPOISearcherDelegate.h"
#import "SearchResultController.h"
#import "NSString+AutoCountLabelSize.h"
#import "RefreshCoverView.h"
@interface InquiryViewController ()<UISearchBarDelegate,ITipSearcherDelegate,SearchResultControllerDelegate,IPOISearcherDelegate>
@property(nonatomic,strong)QMUIFloatLayoutView *floatLayoutView;
@property(nonatomic,strong)UISearchBar *searchBar;
/** 搜索自动联想功能 */
@property(nonatomic,strong)id<ITipSearcher>searcherService;
/** 自动联想搜索结果 */
@property(nonatomic,strong)NSArray *tips;
/** POI附近检索功能 */
@property(nonatomic,strong)id<IPOISearcher>POISearcher;

@property(nonatomic,strong)SearchResultController *searchResultViewController;

@end

@implementation InquiryViewController
- (QMUIFloatLayoutView *)floatLayoutView
{
    if (_floatLayoutView==nil) {
        _floatLayoutView = [[QMUIFloatLayoutView alloc] init];
        _floatLayoutView.padding = UIEdgeInsetsMake(15, 15, 15, 15);
        _floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
        _floatLayoutView.minimumItemSize = CGSizeMake(65, 29);// 以2个字的按钮作为最小宽度
        _floatLayoutView.layer.borderWidth = 0;
        _floatLayoutView.layer.borderColor = UIColorSeparator.CGColor;
    }
    return _floatLayoutView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = @"输入搜索关键字";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (SearchResultController *)searchResultViewController
{
    if (_searchResultViewController == nil) {
        _searchResultViewController = [[SearchResultController alloc] init];
        _searchResultViewController.delegate = self;
    }
    
    return _searchResultViewController;
}

- (id<ITipSearcher>)searcherService
{
    if (_searcherService==nil) {
        _searcherService = [_factory getSearcher];
        [_searcherService setDelegate:self];
    }
    return _searcherService;
}

- (id<IPOISearcher>)POISearcher
{
    if (_POISearcher==nil) {
        _POISearcher = [_factory getPOISearcher];
    }
    return _POISearcher;
}

- (void)initSubviews {
    [super initSubviews];
    [self commonInit];
}

- (void)commonInit
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.floatLayoutView];
    
    NSArray<NSString *> *suggestions = @[@"小吃快餐", @"KTV", @"电影院", @"超市", @"停车场", @"青年旅社", @"厕所",@"名胜古迹"];
    for (NSInteger i = 0; i < suggestions.count; i++) {
        QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
        button.ghostColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
        [button setTitle:suggestions[i] forState:UIControlStateNormal];
        button.titleLabel.font = UIFontMake(14);
        //设置button的左右上下距离
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 10, 6, 10);
        [button addTarget:self action:@selector(keywordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.floatLayoutView addSubview:button];
        
        [self addChildViewController:self.searchResultViewController];
        [self.view addSubview:self.searchResultViewController.view];
        self.searchResultViewController.view.hidden = YES;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    
    UIEdgeInsets padding = UIEdgeInsetsMake(CGRectGetMaxY(self.searchBar.frame) + 25, 15, 25, 15);
    CGFloat contentWidth = CGRectGetWidth(self.view.bounds) - UIEdgeInsetsGetHorizontalValue(padding);
    CGSize floatLayoutViewSize = [self.floatLayoutView sizeThatFits:CGSizeMake(contentWidth, CGFLOAT_MAX)];
    self.floatLayoutView.frame = CGRectMake(padding.left, padding.top, contentWidth, floatLayoutViewSize.height);
    self.searchResultViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), self.view.bounds.size.width, CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.searchBar.frame));
}

- (void)showSearchResultViewControllerWithData:(NSArray *)data type:(SearchResultViewControllerType)type
{
    self.searchResultViewController.view.hidden = NO;
    if (type == SearchResultViewControllerTypeShowTips) {
        self.searchResultViewController.tips = data;
    }
    else{
        self.searchResultViewController.poiSearchResults = data;
    }
    
    self.searchResultViewController.showType = type;
    
    [self.searchResultViewController reloadData];
}

- (void)dismissSearchResultViewController
{
    self.searchResultViewController.view.hidden = YES;
}

#pragma mark - 点击默认关键字按钮进行poi附近检索
- (void)keywordButtonClicked:(QMUIGhostButton *)button
{
    NSString *keyword = [button currentTitle];
    [self startPOISearchWithKeyword:keyword];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self beginSearchWithText:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [self beginSearchWithText:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [self dismissSearchResultViewController];
}

#pragma mark - 开始进行tip搜索功能
- (void)beginSearchWithText:(NSString *)text
{
    if (text==nil||[text isEmptyString]) {
        return;
    }
    [self.searcherService setSearchKeyword:text];
    __weak typeof (self) weakSelf = self;
    //调用在线搜索功能实现自动联想
    [self.searcherService setLocation:_userLocation reverseGeoSearchSuccess:^{
        [weakSelf.searcherService startSearching];
    }];
}

#pragma mark - ISearcherDelegate tip搜索功能的回调
- (void)onGetTipSearchResult:(NSArray<id<ISearchTip>> *)results
{
    _tips = results;
    [self showSearchResultViewControllerWithData:results type:SearchResultViewControllerTypeShowTips];
}

#pragma mark - IPOISearcherDelegate POI附近检索功能回调
- (void)onGetPOISearchResults:(NSArray<id<IPOISearchResult>> *)results
{
    [RefreshCoverView endRefreshing];
    [self showSearchResultViewControllerWithData:results type:SearchResultViewControllerTypeShowPOIInfo];
}

#pragma mark - SearchResultControllerDelegate
- (void)searchResultControllerDidScroll:(SearchResultController *)searchResultController
{
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - searchResult控制器点击cell的回调
- (void)searchResultController:(SearchResultController *)searchResultController didSelectedSearchResult:(id)result showType:(SearchResultViewControllerType)showType
{
    switch (showType) {
        case SearchResultViewControllerTypeShowTips:
        {
            id<ISearchTip>tip = result;
            if (![tip.getPoiId isEmptyString]) {//该tip搜索结果是一个具体的POI点，直接返回地图页面开始POI详情检索
                if ([_delegate respondsToSelector:@selector(PoiDetailSearchWithPoiID:)]) {
                    [_delegate PoiDetailSearchWithPoiID:tip.getPoiId];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{//该tip搜索结果不是具体POI点，只是关键字，开始POI检索以获取poi列表
                [self startPOISearchWithKeyword:tip.getName];
            }
            break;
        }
        case SearchResultViewControllerTypeShowPOIInfo:
        {
            id<IPOISearchResult>poiResult = result;
            if (![poiResult.getPoiId isEmptyString]) {//该poiResult是一个具体的POI点，返回地图页面开始POI详情检索
                if ([_delegate respondsToSelector:@selector(PoiDetailSearchWithPoiID:)]) {
                    [_delegate PoiDetailSearchWithPoiID:poiResult.getPoiId];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{//该poiResult不包含poiID，重新进行poi检索，不太可能出现这个情况
                [self startPOISearchWithKeyword:poiResult.getName];
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)startPOISearchWithKeyword:(NSString *)keyword
{
    [RefreshCoverView beginRefreshingWithEdgeToView:UIEdgeInsetsZero backgroundColor:[UIColor clearColor] addToView:self.view];
    [self.POISearcher setKeyword:keyword];
    [self.POISearcher setLocation:_userLocation];
    [self.POISearcher setDelegate:self];
    [self.POISearcher startSearching];
}

@end
