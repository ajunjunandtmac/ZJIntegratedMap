//
//  GaodeLocationService.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeLocationService.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "GaodeUserLocation.h"
@interface GaodeLocationService ()<AMapLocationManagerDelegate>
@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,weak)id<ILocationServiceDelegate>delegate;
@end

@implementation GaodeLocationService
- (instancetype)initWithDelegate:(id<ILocationServiceDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 200;
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        [_locationManager setAllowsBackgroundLocationUpdates:YES];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.locationTimeout = 10;
    }
    return self;
}

- (void)startLocation
{
    [self.locationManager setLocatingWithReGeocode:YES];
    [_locationManager startUpdatingLocation];
}

- (void)stopLocation
{
    [_locationManager stopUpdatingLocation];
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    GaodeUserLocation *userLocation = [[GaodeUserLocation alloc] initWithCLLocation:location];
    [_delegate didUpdateUserLocation:userLocation];
    [self stopLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error=%@",error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}
@end
