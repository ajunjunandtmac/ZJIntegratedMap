//
//  GQCircleLoadView.m
//  Family
//
//  Created by jiale on 2017/3/1.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "GQCircleLoadView.h"
#define WINDOW_width [[UIScreen mainScreen] bounds].size.width
#define WINDOW_height [[UIScreen mainScreen] bounds].size.height
#define APPThemeColor [UIColor colorWithRed:93/255.0 green:196/255.0 blue:165/255.0 alpha:1]
static NSInteger circleCount = 3;
static CGFloat cornerRadius = 5;
static CGFloat magin = 15;
@interface GQCircleLoadView()<CAAnimationDelegate>
@property (nonatomic, strong) NSMutableArray *layerArr;
@property(nonatomic,strong)NSArray<UIColor *> *dotColors;
@end

@implementation GQCircleLoadView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _dotColors = @[
                       APPThemeColor,
                       APPThemeColor,
                       APPThemeColor
                       ];
    }
    return self;
}
// 画圆
- (void)drawCircles{
    for (NSInteger i = 0; i < circleCount; ++i) {
        CGFloat x = (WINDOW_width - (cornerRadius*2) * circleCount - magin * (circleCount-1)) / 2.0 + i * (cornerRadius*2 + magin) + cornerRadius;
        CGRect rect = CGRectMake(-cornerRadius, -cornerRadius , 2*cornerRadius, 2*cornerRadius);
        UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = beizPath.CGPath;
        layer.fillColor=_dotColors[i].CGColor;
        layer.position = CGPointMake(x, self.frame.size.height * 0.5);
        [self.layer addSublayer:layer];
        [self.layerArr addObject:layer];
    }
    //先让第一个点动起来，然后在动画代理方法中让后面的点动起来
    [self drawAnimation:self.layerArr[0]];
    
    // 旋转(可打开试试效果)
//     CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//     rotationAnimation.toValue = [NSNumber numberWithFloat: - M_PI * 2.0 ];
//     rotationAnimation.duration = 1;
//     rotationAnimation.cumulative = YES;
//     rotationAnimation.repeatCount = MAXFLOAT;
//     [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


// 动画实现
- (void)drawAnimation:(CALayer*)layer {
    CABasicAnimation *scaleUp = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleUp.fromValue = @1;
    scaleUp.toValue = @1.5;
    scaleUp.duration = 0.25;
    scaleUp.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *scaleDown = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleDown.beginTime = scaleUp.duration;
    scaleDown.fromValue = @1.5;
    scaleDown.toValue = @1;
    scaleDown.duration = 0.25;
    scaleDown.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[scaleUp, scaleDown];
    group.repeatCount = 0;
    group.duration = scaleUp.duration + scaleDown.duration;
    group.delegate = self;
    [layer addAnimation:group forKey:@"groupAnimation"];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim isKindOfClass:CAAnimationGroup.class]) {
        CAAnimationGroup *animation = (CAAnimationGroup *)anim;
        
        [self.layerArr enumerateObjectsUsingBlock:^(CAShapeLayer *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CAAnimationGroup *a0 = (CAAnimationGroup *)[obj animationForKey:@"groupAnimation"];
            if (a0 && a0 == animation) {
                CAShapeLayer *nextlayer = self.layerArr[(idx+1)>=self.layerArr.count?0:(idx+1)];//实现子layer循环动画 0 1 2 -> 0 1 2
                [self performSelector:@selector(drawAnimation:) withObject:nextlayer afterDelay:0.25];
                *stop = YES; //开启一个layer动画后就停止遍历，等待下次animationDidStart被调用时再开启下一个layer的动画
            }
        }];
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self drawCircles];
}

- (NSMutableArray *)layerArr{
    if (_layerArr == nil) {
        _layerArr = [[NSMutableArray alloc] init];
    }
    return _layerArr;
}

- (void)beginAnimation
{
    [self drawCircles];
}

@end

