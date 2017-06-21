//
//  BaiduAnnotationView.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/19.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAnnotationView.h"
@class BMKAnnotationView;
@interface BaiduAnnotationView : NSObject<IAnnotationView>
- (instancetype)initWithBMKAnnotationView:(BMKAnnotationView *)annotationView;
@end
