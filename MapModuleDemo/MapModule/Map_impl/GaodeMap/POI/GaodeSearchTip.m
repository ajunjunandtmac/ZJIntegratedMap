//
//  BaiduSearchTip.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeSearchTip.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface GaodeSearchTip ()
@property(nonatomic,strong)AMapTip *tip;
@end

@implementation GaodeSearchTip
- (instancetype)initWithAMapTip:(AMapTip *)tip
{
    self = [super init];
    if (self) {
        _tip = tip;
    }
    return self;
}
- (NSString *)getPoiId
{
    return _tip.uid;
}

- (NSString *)getName
{
    return _tip.name;
}

- (NSString *)getAddress
{
    return _tip.address;
}

- (CLLocationCoordinate2D)getLocation
{
    return CLLocationCoordinate2DMake(_tip.location.longitude, _tip.location.latitude);
}
@end
