//
//  ILocationServiceDelegate.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "IUserLocation.h"
@protocol ILocationServiceDelegate <NSObject>
- (void)didUpdateUserLocation:(id<IUserLocation>)userLocation;
@end
