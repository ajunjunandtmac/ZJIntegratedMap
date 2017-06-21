//
//  SearchResultController.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISearchTip.h"
#import "IPOISearchResult.h"
typedef NS_ENUM(NSUInteger,SearchResultViewControllerType){
    SearchResultViewControllerTypeShowTips,
    SearchResultViewControllerTypeShowPOIInfo
};
@class SearchResultController;
@protocol SearchResultControllerDelegate <NSObject>
@optional
- (void)searchResultControllerDidScroll:(SearchResultController *)searchResultController;
- (void)searchResultController:(SearchResultController *)searchResultController didSelectedSearchResult:(id)result showType:(SearchResultViewControllerType)showType;
@end

@interface SearchResultController : UIViewController
@property(nonatomic,assign)SearchResultViewControllerType showType;
@property(nonatomic,strong)NSArray<id<ISearchTip>> *tips;
@property(nonatomic,strong)NSArray<id<IPOISearchResult>> *poiSearchResults;
@property(nonatomic,weak)id<SearchResultControllerDelegate>delegate;
- (void)reloadData;
@end
