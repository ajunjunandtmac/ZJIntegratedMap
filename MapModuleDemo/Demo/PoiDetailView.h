//
//  PoiDetailView.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/18.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoiDetailViewFrameTool.h"
@protocol PoiDetailViewDelegate<NSObject>
@optional
- (void)arrowDownButtonClicked;
- (void)goThereButtonClickedWithPoiInfo:(id<IPoiDetailSearchResult>)poiDetailInfo;
@end

@interface PoiDetailView : UIView
@property(nonatomic,strong)PoiDetailViewFrameTool *tool;
- (void)configureWithPoiDetailViewTool:(PoiDetailViewFrameTool *)tool delegate:(id<PoiDetailViewDelegate>)delegate;
@end
