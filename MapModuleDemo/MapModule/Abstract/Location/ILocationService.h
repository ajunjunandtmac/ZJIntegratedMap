//
//  ImapLocation.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//  生产定位功能的抽象工厂

#import <Foundation/Foundation.h>
#import "ILocationServiceDelegate.h"
@protocol ILocationServiceDelegate;
@protocol ILocationService <NSObject>
- (instancetype)initWithDelegate:(id<ILocationServiceDelegate>)delegate;
- (void)startLocation;
- (void)stopLocation;
@end
