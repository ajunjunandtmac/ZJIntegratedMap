//
//  ZJXMLParse.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Platform.h"
typedef NS_ENUM(NSUInteger,MapPlatformType){
    /** 通过xml配置文件来决定显示的地图类型 */
    MapPlatformTypeFromConfigXML = 0,
    MapPlatformTypeBaidu = 1,
    MapPlatformTypeGaode = 2
};
@interface ZJMapConfigXMLParse : NSObject<NSXMLParserDelegate>
+ (instancetype)parser;

/**
 通过xml中的isOpen去读取要显示的地图类型

 @return isOpen="1"的platform对象
 */
- (Platform *)parse;

- (Platform *)parseWithMapType:(MapPlatformType)type;
@end
