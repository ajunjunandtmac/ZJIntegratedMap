//
//  KTUpDownAnimationController.m
//  KTAlertController
//
//  Created by Kevin on 16/8/14.
//  Copyright © 2016年 Kevin. All rights reserved.
//  remark:present的时候alertController是destination  dismiss的时候alertController是source

#import "ZJUpDownViewControllerAnimatedTransitioning.h"
#import "ZJAlertControllerProtocol.h"

@implementation ZJUpDownViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 1
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

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController<ZJAlertControllerProtocol> *destination = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *source = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!source || !destination) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (destination.isBeingPresented) {
        // 2
        [containerView addSubview:destination.view];
        destination.view.frame = CGRectMake(0.0, 0.0, containerView.frame.size.width, containerView.frame.size.height);
        destination.getCover.alpha = 0.0;
        destination.getContentView.center = CGPointMake(containerView.center.x, 0);
        [UIView animateWithDuration:duration animations:^{
            destination.getCover.alpha = 0.3;
            destination.getContentView.center = containerView.center;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else if (source.isBeingDismissed) {
        // 3
        [UIView animateWithDuration:duration animations:^{
            source.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
