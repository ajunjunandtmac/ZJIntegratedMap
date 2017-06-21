//
//  ZJTransition.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/14.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>
+ (instancetype)delegate;
@end
