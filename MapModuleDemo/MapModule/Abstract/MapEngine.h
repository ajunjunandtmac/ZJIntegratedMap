//
//  MapEngine.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//  地图框架程序入口

#import <Foundation/Foundation.h>
#import "IMapFactoryProtocol.h"
#import "ZJMapConfigXMLParse.h"

@interface MapEngine : NSObject
+ (id<IMapFactoryProtocol>)mapFactory;
+ (id<IMapFactoryProtocol>)mapFactoryWithType:(MapPlatformType)type;
@end
