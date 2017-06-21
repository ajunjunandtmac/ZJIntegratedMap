//
//  IMapViewProtocol.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//  抽象mapView工厂方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IUserLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "IAnnotation.h"
#import "IPoiDetailSearchResult.h"
#import "IMapDelegate.h"
#import "INaviRoutePoint.h"
typedef NS_ENUM(NSUInteger,ZJMapUserTrackingMode) {
    ZJMapUserTrackingModeNone = 0,             /// 普通定位模式
    ZJMapUserTrackingModeHeading,              /// 定位方向模式
    ZJMapUserTrackingModeFollow,               /// 定位跟随模式
    ZJMapUserTrackingModeFollowWithHeading,    /// 定位罗盘模式
};

///经度、纬度定义的经纬度跨度范围
struct ZJMapCoordinateSpan{
    CLLocationDegrees latitudeDelta;  ///< 纬度跨度
    CLLocationDegrees longitudeDelta; ///< 经度跨度
};
typedef struct ZJMapCoordinateSpan ZJMapCoordinateSpan;

///中心点、跨度范围定义的四边形经纬度范围
struct ZJMapCoordinateRegion{
    CLLocationCoordinate2D center;  ///< 中心点经纬度
    ZJMapCoordinateSpan span;          ///< 跨度范围
};
typedef struct ZJMapCoordinateRegion ZJMapCoordinateRegion;

/** c方法只能在实现类中保留一份实现，切记 */
ZJMapCoordinateSpan ZJMapCoordinateSpanMake(CLLocationDegrees latitudeDelta,CLLocationDegrees longitudeDelta);

ZJMapCoordinateRegion ZJMapCoordinateRegionMake(CLLocationCoordinate2D center,ZJMapCoordinateSpan span);


@protocol IMapProtocol <NSObject>
//实例化mapView工厂
- (instancetype)initWithFrame:(CGRect)frame;

//生产mapView
- (UIView *)getMapView;

/** 设置代理，监听回调 */
- (void)setDelegate:(id<IMapDelegate>)delegate;

/** 跟踪定位,被动更新位置，百度地图专用 */
- (void)updateUserLocation:(id<IUserLocation>)userLocation;

/** 设置用户跟踪的方式 */
- (void)setUserTrackingMode:(ZJMapUserTrackingMode)mode;

/** 设置用户位置 */
- (void)showsUserLocation:(BOOL)show;

/** 设置地图显示的范围 */
- (void)setRegion:(ZJMapCoordinateRegion)region;


/**
 生产大头针 新大头针默认是选中状态
 @param annotation 传nil添加百度或者高德的默认annotation
 @param poiInfo poi详情搜索的结果对象
 */
- (void)addPointAnnotation:(id<IAnnotation>)annotation poi:(id<IPoiDetailSearchResult>)poiInfo;


/**
 - (void)storeSelectedAnnotationView:(id<IAnnotationView>)annotationView;
 - (void)deSelectAnnotationView;
 这两个方法要配合一起使用

 当选中annotationView的代理方法回调后先保存选中的annotationView
 在需要的时候再调用deselectAnnotationView消除annotationView的选中状态
 使用业务场景：当选中大头针后上弹一个poi详情页
 如果点击地图其他处，会自动调用annotation的deselected方法消除大头针的选中状态
 如果点击poi详情页的下箭头收起详情页，但是不会消除大头针的选中状态
 此时必须主动调用deSelectAnnotationView主动消除大头针的选中状态
 */
- (void)storeSelectedAnnotationView:(id<IAnnotationView>)annotationView;
- (void)deselectAnnotationView;

/** 生产路径规划功能 */
- (void)addRouteLinesWithRoutes:(NSArray<NSDictionary<NSNumber *,NSArray<id<INaviRoutePoint>> *>*> *)routes;
@end
