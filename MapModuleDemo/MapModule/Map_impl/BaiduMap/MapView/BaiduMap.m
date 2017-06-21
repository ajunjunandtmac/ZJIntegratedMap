//
//  BaiduMapView.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduMap.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Map/BMKPolylineView.h>
#import <BaiduMapAPI_Map/BMKOverlay.h>
#import "BaiduAnnotationView.h"
@interface BaiduMap ()<BMKMapViewDelegate>
@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,weak)id<IMapDelegate>delegate;
@property(nonatomic,strong)id<IPoiDetailSearchResult>poiDetailInfo;
@property(nonatomic,strong)BaiduAnnotationView *selectedAnnotationView;
@end
@implementation BaiduMap
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _mapView = [[BMKMapView alloc] initWithFrame:frame];
        _mapView.delegate = self;
        
        //取出精度圈
        BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
        displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
        displayParam.isAccuracyCircleShow = false;//精度圈是否显示
        displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
        displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
        [_mapView updateLocationViewWithParam:displayParam];
    }
    
    return self;
}

- (UIView *)getMapView
{
    return _mapView;
}

- (void)setDelegate:(id<IMapDelegate>)delegate
{
    _delegate = delegate;
}

- (void)updateUserLocation:(id<IUserLocation>)userLocation
{
    BMKUserLocation *userLoc = userLocation.SDKOriginalUserLocation;
    [_mapView updateLocationData:userLoc];
}

- (void)setUserTrackingMode:(ZJMapUserTrackingMode)mode
{
    _mapView.userTrackingMode = (BMKUserTrackingMode)mode;
}

- (void)showsUserLocation:(BOOL)show
{
    _mapView.showsUserLocation = show;
}

- (void)setRegion:(ZJMapCoordinateRegion)region
{
    BMKCoordinateRegion BMKRegion = {region.center,{region.span.latitudeDelta,region.span.longitudeDelta}};
    _mapView.region = BMKRegion;
}

- (void)addPointAnnotation:(id<IAnnotation>)annotation poi:(id<IPoiDetailSearchResult>)poiInfo{
    _poiDetailInfo = poiInfo;
    //先移除已有的annotation,会触发annotationview未选中的代理方法
    [_mapView removeAnnotations:_mapView.annotations];
    if (annotation==nil) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
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

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        [newAnnotationView setSelected:YES];
        [newAnnotationView setCanShowCallout:NO];//不让弹出气泡
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - 大头针添加到view上就通知地图显示控制器上弹poi详情
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    if ([_delegate respondsToSelector:@selector(mapViewDidAddAnnotationView:poiDetailInfo:)]) {
        
        BaiduAnnotationView *annotationView = [[BaiduAnnotationView alloc] initWithBMKAnnotationView:(BMKAnnotationView *)views[0]];
        
        [_delegate mapViewDidAddAnnotationView:annotationView poiDetailInfo:_poiDetailInfo];
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    if ([_delegate respondsToSelector:@selector(mapViewDidSelectAnnotationView:poiDetailInfo:)]) {
        BaiduAnnotationView *annotationView = [[BaiduAnnotationView alloc] initWithBMKAnnotationView:view];
        [_delegate mapViewDidSelectAnnotationView:annotationView poiDetailInfo:_poiDetailInfo];
    }
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    if ([_delegate respondsToSelector:@selector(mapViewDidDeselectAnnotationView:poiDetailInfo:)]) {
        BaiduAnnotationView *annotationView = [[BaiduAnnotationView alloc] initWithBMKAnnotationView:view];
        [_delegate mapViewDidDeselectAnnotationView:annotationView poiDetailInfo:_poiDetailInfo];
    }
}

- (void)addRouteLinesWithRoutes:(NSArray<NSDictionary<NSNumber *,NSArray<id<INaviRoutePoint>> *> *> *)routes
{
    [_mapView removeOverlays:_mapView.overlays];
    for (int i = 0; i<routes.count; i++) {
        NSDictionary *routeLine = routes[i];
        NSArray<id<INaviRoutePoint>> *routePoints = routeLine[@(i)];
        
        CLLocationCoordinate2D polylineCoords[routePoints.count];
        for (int i = 0; i<routePoints.count; i++) {
            polylineCoords[i] = routePoints[i].getRouteCoordinate;
        }
        
        //构造折线对象
        BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:polylineCoords     count:routePoints.count];
        [_mapView addOverlay:polyline];
    }
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineView.lineWidth = 4.0;
        
        return polylineView;
    }
    return nil;
}

@end
