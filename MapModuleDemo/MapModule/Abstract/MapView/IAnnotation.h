//
//  IAnnotation.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//  自定义Annotation

#import <Foundation/Foundation.h>

@protocol IAnnotation <NSObject>
///标注view中心坐标.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@optional

/**
 *获取annotation标题
 *@return 返回annotation的标题信息
 */
- (NSString *)title;

/**
 *获取annotation副标题
 *@return 返回annotation的副标题信息
 */
- (NSString *)subtitle;

/**
 *设置标注的坐标，在拖拽时会被调用.
 *@param newCoordinate 新的坐标值
 */
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
