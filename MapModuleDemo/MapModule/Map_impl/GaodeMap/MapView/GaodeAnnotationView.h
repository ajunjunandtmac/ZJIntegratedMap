//
//  GaodeAnnotationView.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/19.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAnnotationView.h"
@class MAAnnotationView;
@interface GaodeAnnotationView : NSObject<IAnnotationView>
- (instancetype)initWithMAAnnotationView:(MAAnnotationView *)annotationView;
@end
