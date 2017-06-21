//
//  ISearcher.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/16.
//  Copyright © 2017年 jiale. All rights reserved.
//  在线建议搜索抽象工厂类

#import <Foundation/Foundation.h>
#import "ITipSearcherDelegate.h"
#import "IUserLocation.h"
@protocol ITipSearcher <NSObject>
- (void)setDelegate:(id<ITipSearcherDelegate>)delegate;


/**
 反查功能集成在线搜索功能里，根据location反查城市名，不需要调用者自己去实现反查功能
 在success回调中startSearching，确保已经反查到城市名

 @param userLocaton 定位到的用户位置信息
 @param success geo反查成功后的回调
 */
- (void)setLocation:(id<IUserLocation>)userLocaton reverseGeoSearchSuccess:(void (^)())success;
- (void)setSearchKeyword:(NSString *)keyword;
- (void)startSearching;
@end
