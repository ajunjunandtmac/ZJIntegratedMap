//
//  ZJSegmentedView.h
//  Family
//
//  Created by jiale on 2017/4/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJSegmentedView;
@protocol ZJSegmentedViewDelegate<NSObject>
- (void)ZJSegmentedView:(ZJSegmentedView *)segmentedView selectedAtIndex:(NSUInteger)index;
@end

@interface ZJSegmentedView : UIView
- (instancetype)initWithTitles:(NSArray<NSString *>*)titles delegate:(id<ZJSegmentedViewDelegate>)delegate;
- (void)selectAtIndex:(NSUInteger)index;
@end
