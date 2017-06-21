//
//  GaodeAnnotationView.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/19.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GaodeAnnotationView.h"
#import <MAMapKit/MAAnnotationView.h>
@interface GaodeAnnotationView ()
@property(nonatomic,strong)MAAnnotationView *MAAnnotationView;
@end

@implementation GaodeAnnotationView
- (instancetype)initWithMAAnnotationView:(MAAnnotationView *)annotationView
{
    self = [super init];
    if (self) {
        _MAAnnotationView = annotationView;
    }
    return self;
}
- (void)setSelected:(BOOL)selected
{
    [_MAAnnotationView setSelected:selected];
}
@end
