//
//  MapEngine.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "MapEngine.h"
@implementation MapEngine
+ (id<IMapFactoryProtocol>)mapFactory
{
    Platform *platform = [[ZJMapConfigXMLParse parser] parse];
    id<IMapFactoryProtocol> factory = [[NSClassFromString(platform.factoryName) alloc] initWithAppKey:platform.appKey];
    return factory;
}

+ (id<IMapFactoryProtocol>)mapFactoryWithType:(MapPlatformType)type
{
    Platform *platform = [[ZJMapConfigXMLParse parser] parseWithMapType:type];
    id<IMapFactoryProtocol> factory = [[NSClassFromString(platform.factoryName) alloc] initWithAppKey:platform.appKey];
    return factory;
}

@end
