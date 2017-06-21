//
//  BaiduSearchTip.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISearchTip.h"
@class AMapTip;
@interface GaodeSearchTip : NSObject<ISearchTip>
- (instancetype)initWithAMapTip:(AMapTip *)tip;
@end
