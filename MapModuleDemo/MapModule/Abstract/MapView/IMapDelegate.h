//
//  IMapDelegate.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/18.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPoiDetailSearchResult.h"
#import "IAnnotationView.h"
@protocol IMapDelegate <NSObject>
@optional
- (void)mapViewDidAddAnnotationView:(id<IAnnotationView>)annotationView poiDetailInfo:(id<IPoiDetailSearchResult>)poiDetailInfo;

- (void)mapViewDidSelectAnnotationView:(id<IAnnotationView>)annotationView poiDetailInfo:(id<IPoiDetailSearchResult>)poiDetailInfo;

- (void)mapViewDidDeselectAnnotationView:(id<IAnnotationView>)annotationView poiDetailInfo:(id<IPoiDetailSearchResult>)poiDetailInfo;
@end
