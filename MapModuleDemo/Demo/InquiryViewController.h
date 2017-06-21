//
//  InquiryViewController.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/16.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "QDCommonViewController.h"
#import "IMapFactoryProtocol.h"
#import "IUserLocation.h"
@protocol InquiryViewControllerDelegate<NSObject>
- (void)PoiDetailSearchWithPoiID:(NSString *)poiID;
@end

@interface InquiryViewController : QDCommonViewController
@property(nonatomic,strong)id<IMapFactoryProtocol>factory;
@property(nonatomic,strong)id<IUserLocation>userLocation;
@property(nonatomic,weak)id<InquiryViewControllerDelegate>delegate;
@end
