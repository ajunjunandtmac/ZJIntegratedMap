//
//  IAnnotationView.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/19.
//  Copyright © 2017年 jiale. All rights reserved.
//  note:无论是高德还是百度地图的大头针 点击大头针就会触发选中 点击地图其他区域就会触发非选中

#import <Foundation/Foundation.h>

@protocol IAnnotationView <NSObject>
- (void)setSelected:(BOOL)selected;
@end
