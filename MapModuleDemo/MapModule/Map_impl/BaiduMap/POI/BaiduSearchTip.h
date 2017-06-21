//
//  BaiduSearchTip.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISearchTip.h"
@interface BaiduSearchTip : NSObject<ISearchTip>
@property(nonatomic,copy)NSString *poiId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)CLLocationCoordinate2D location;
@end
