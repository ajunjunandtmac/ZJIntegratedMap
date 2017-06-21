//
//  GaodeMap.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeMap.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAUserLocationRepresentation.h>
#import "GaodeAnnotationView.h"
ZJMapCoordinateSpan ZJMapCoordinateSpanMake(CLLocationDegrees latitudeDelta,CLLocationDegrees longitudeDelta)
{
    return (ZJMapCoordinateSpan){latitudeDelta,longitudeDelta};
}

ZJMapCoordinateRegion ZJMapCoordinateRegionMake(CLLocationCoordinate2D center,ZJMapCoordinateSpan span)
{
    return (ZJMapCoordinateRegion){center,span};
}


@interface GaodeMap()<MAMapViewDelegate>
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,weak)id<IMapDelegate>delegate;
@property(nonatomic,strong)id<IPoiDetailSearchResult>poiDetailInfo;
@property(nonatomic,strong)GaodeAnnotationView *selectedAnnotationView;
@end

@implementation GaodeMap
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _mapView = [[MAMapView alloc] initWithFrame:frame];
        _mapView.delegate = self;
        ///是否自定义用户位置精度圈(userLocationAccuracyCircle)对应的 view, 默认为 NO.\n 如果为YES: 会调用 - (MAOverlayRenderer *)mapView (MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay 若返回nil, 则不加载.\n 如果为NO : 会使用默认的样式.
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    }
    return self;
}

/** 取消精度圈 */
//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
//{
//    return nil;
//}

- (UIView *)getMapView
{
    return _mapView;
}

- (void)setDelegate:(id<IMapDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setUserTrackingMode:(ZJMapUserTrackingMode)mode
{
    MAUserTrackingMode MAUserTrackingMode = MAUserTrackingModeNone;
    switch (mode) {
        case ZJMapUserTrackingModeNone:
            MAUserTrackingMode = MAUserTrackingModeNone;
            break;
        case ZJMapUserTrackingModeFollow:
            MAUserTrackingMode = MAUserTrackingModeFollow;
            break;
        case ZJMapUserTrackingModeFollowWithHeading:
            MAUserTrackingMode = MAUserTrackingModeFollowWithHeading;
            break;
        default:
            break;
    }
    _mapView.userTrackingMode = MAUserTrackingMode;
}

- (void)showsUserLocation:(BOOL)show
{
    _mapView.showsUserLocation = show;
}

- (void)updateUserLocation:(id<IUserLocation>)userLocation
{
    //高德不需要手动调用方法更新位置
}

- (void)setRegion:(ZJMapCoordinateRegion)region
{
    MACoordinateRegion MARegion = {region.center,{region.span.latitudeDelta,region.span.longitudeDelta}};
    _mapView.region = MARegion;
}

/** 高德地图查高德绘制点标记文件 */
- (void)addPointAnnotation:(id<IAnnotation>)annotation poi:(id<IPoiDetailSearchResult>)poiInfo
{
    _poiDetailInfo = poiInfo;
    //先移除已有的annotation 会触发annotationview未选中的代理方法
    for (int i=0; i<_mapView.annotations.count; i++) {
        MAPointAnnotation *annotation = _mapView.annotations[i];
        if ([annotation isKindOfClass:[MAUserLocation class]]) {
            continue;
        }
        [_mapView removeAnnotation:annotation];
    }
    if (annotation==nil) {
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = poiInfo.getLocation;
        annotation.title = poiInfo.getName;
        annotation.subtitle = poiInfo.address;
        //[_mapView selectAnnotation:annotation animated:YES];
        [_mapView addAnnotation:annotation];
    }
}

- (void)storeSelectedAnnotationView:(id<IAnnotationView>)annotationView
{
    _selectedAnnotationView = annotationView;
}

- (void)deselectAnnotationView
{
    [_selectedAnnotationView setSelected:NO];
}


#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isMemberOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= NO;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorGreen;
        [annotationView setSelected:YES]; //默认选中状态
        return annotationView;
    }
    return nil;
}

#pragma mark - 大头针添加到view上就通知地图显示控制器上弹poi详情
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    if (![views[0] isMemberOfClass:[MAPinAnnotationView class]]) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(mapViewDidAddAnnotationView:poiDetailInfo:)]) {
        GaodeAnnotationView *annotationView = [[GaodeAnnotationView alloc] initWithMAAnnotationView:(MAAnnotationView *)views[0]];
        [_delegate mapViewDidAddAnnotationView:annotationView poiDetailInfo:_poiDetailInfo];
    }
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if (![view isMemberOfClass:[MAPinAnnotationView class]]) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(mapViewDidSelectAnnotationView:poiDetailInfo:)]) {
        GaodeAnnotationView *annotationView = [[GaodeAnnotationView alloc] initWithMAAnnotationView:view];
        [_delegate mapViewDidSelectAnnotationView:annotationView poiDetailInfo:_poiDetailInfo];
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    if (![view isMemberOfClass:[MAPinAnnotationView class]]) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(mapViewDidDeselectAnnotationView:poiDetailInfo:)]) {
        GaodeAnnotationView *annotationView = [[GaodeAnnotationView alloc] initWithMAAnnotationView:view];
        [_delegate mapViewDidDeselectAnnotationView:annotationView poiDetailInfo:_poiDetailInfo];
    }
}

- (void)addRouteLinesWithRoutes:(NSArray<NSDictionary<NSNumber *,NSArray<id<INaviRoutePoint>> *> *> *)routes
{
    //移除之前的polyLine
    [_mapView removeOverlays:_mapView.overlays];
    for (int i = 0; i<routes.count; i++) {
        NSDictionary *routeLine = routes[i];
        NSArray<id<INaviRoutePoint>> *routePoints = routeLine[@(i)];
        
        CLLocationCoordinate2D polylineCoords[routePoints.count];
        for (int i = 0; i<routePoints.count; i++) {
            polylineCoords[i] = routePoints[i].getRouteCoordinate;
        }
        
        //构造折线对象
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords     count:routePoints.count];
        [_mapView addOverlay:polyline];
    }
}

#pragma mark - 路径规划画线+取消精度圈
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;//取消精度圈
}

@end
