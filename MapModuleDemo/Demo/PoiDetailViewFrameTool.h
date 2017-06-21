//
//  PoiDetailViewFrameTool.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/18.
//  Copyright © 2017年 jiale. All rights reserved.
//  view结构
//  背景透明色，圆球从y=0开始布局，位于图层最上层
//  info背景白色，从圆球的中心点开始布局，图层位于圆球的下层
//  动画上弹时，要把info的顶部上弹至父视图的下方，这样圆球的一般位于view，另外一般位于父视图上

#import <Foundation/Foundation.h>
#import "IPoiDetailSearchResult.h"
#import "QDUIHelper.h"
#define titleLabelFont UIFontBoldMake(14)
#define addressLabelFont UIFontMake(11)
#define distanceShowLabelFont UIFontMake(11)
@interface PoiDetailViewFrameTool : NSObject
- (void)configureFrameWithPoiDetailInfo:(id<IPoiDetailSearchResult>)result viewWidth:(CGFloat)viewWidth;
@property(nonatomic,strong)id<IPoiDetailSearchResult> poiDetailInfo;
@property(nonatomic,assign)CGRect goThereButtonRect;
@property(nonatomic,assign)CGRect infoBackViewRect;
@property(nonatomic,assign)CGRect arrowDownButtonRect;
@property(nonatomic,assign)CGRect titleLabelRect;
@property(nonatomic,assign)CGRect addressLabelRect;
@property(nonatomic,assign)CGRect distanceShowButtonRect;
@property(nonatomic,assign)CGFloat viewHeight;

/** 上弹动画的移动距离计算，地图要比view少移动圆形按钮一半的高度，这样圆形按钮才有盖住地图的效果 */
@property(nonatomic,assign)CGFloat animateVerticalMoveDistance;
@end
