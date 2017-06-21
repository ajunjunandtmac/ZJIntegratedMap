//
//  ZJTransition.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJTransitioningDelegate.h"
#import "ZJCenterViewControllerAnimatedTransitioning.h"
static ZJTransitioningDelegate *delegate = nil;
@implementation ZJTransitioningDelegate
+ (instancetype)delegate
{
    if (delegate==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            delegate = [[ZJTransitioningDelegate alloc] init];
        });
    }
    
    return delegate;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (delegate==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            delegate = [super allocWithZone:zone];
        });
    }
    return delegate;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[ZJCenterViewControllerAnimatedTransitioning alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[ZJCenterViewControllerAnimatedTransitioning alloc] init];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
//
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0);
@end
