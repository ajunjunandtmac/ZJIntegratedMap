//
//  ZJCenterViewControllerAnimatedTransitioning.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//  remark:present的时候alertController是destination  dismiss的时候alertController是source

#import "ZJCenterViewControllerAnimatedTransitioning.h"

@implementation ZJCenterViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *destination = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *source = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (destination.isBeingPresented) {
        return 0.3;
    }
    else if (source.isBeingDismissed) {
        return 0.1;
    }
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController<ZJAlertControllerProtocol> *destination = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController<ZJAlertControllerProtocol> *source = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!destination || !source) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (destination.isBeingPresented) {
        // 2
        [containerView addSubview:destination.view];
        destination.view.frame = CGRectMake(0.0, 0.0, containerView.frame.size.width, containerView.frame.size.height);
        destination.getCover.alpha = 0.0;
        CGAffineTransform oldTransform = destination.getContentView.transform;
        destination.getContentView.transform = CGAffineTransformScale(oldTransform, 0.3, 0.3);
        destination.getContentView.center = containerView.center;
        [UIView animateWithDuration:duration animations:^{
            destination.getCover.alpha = 0.3;
            destination.getContentView.transform = oldTransform;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else if (source.isBeingDismissed) {
        // 3
        [UIView animateWithDuration:duration animations:^{
            source.getCover.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
