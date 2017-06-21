//
//  BaiduAnnotationView.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/19.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "BaiduAnnotationView.h"
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
@interface BaiduAnnotationView ()
@property(nonatomic,strong)BMKAnnotationView *BMKAnnotationView;
@end

@implementation BaiduAnnotationView
- (instancetype)initWithBMKAnnotationView:(BMKAnnotationView *)annotationView
{
    self = [super init];
    if (self) {
        _BMKAnnotationView = annotationView;
    }
    return self;
}
- (void)setSelected:(BOOL)selected
{
    [_BMKAnnotationView setSelected:selected];
}
@end
