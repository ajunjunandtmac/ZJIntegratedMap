//
//  RefreshCoverView.h
//  Tea
//
//  Created by jiale on 16/7/13.
//  Copyright © 2016年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^serverErrorHandler)();
@interface RefreshCoverView : UIView
- (void)startRefreshing;
- (void)stopRefreshing;
- (void)stopRefreshingDueToServerErrorWithHandler:(serverErrorHandler)handler;


/**
 *  以下三个方法不用实例化，直接显示在最上层window上
 */
+ (void)beginRefreshingWithEdgeToView:(UIEdgeInsets)edgeToView backgroundColor:(UIColor *)backgroundColor addToView:(UIView *)view;
+ (void)beginRefreshingAndAddToView:(UIView *)view;
+ (void)endRefreshing;
+ (void)endRefreshingDueToServerErrorWithHandler:(serverErrorHandler)handler;
@end
