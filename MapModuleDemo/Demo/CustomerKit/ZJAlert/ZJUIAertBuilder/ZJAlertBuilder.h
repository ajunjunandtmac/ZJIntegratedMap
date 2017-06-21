//
//  ZJAlertBuilder.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/6.
//  Copyright © 2017年 jiale. All rights reserved.
//  构建UIAlertController

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ZJAlertConfirmActionHandler)(UIAlertAction *action, NSString *inputText);

@interface ZJAlertBuilder : NSObject

/**
 因为涉及到有textField，设计的繁琐了一点，如果想得到确认按钮以及输入框的回调，请实现它
 */
@property(nonatomic,copy)ZJAlertConfirmActionHandler confirmActionHandler;

/**
 builder初始化方法

 @param context 当前控制器
 @return builder实例
 */
+ (ZJAlertBuilder *)builderWithContext:(UIViewController *)context;

/**
 链式调用构建Alert
 */
- (ZJAlertBuilder *(^)(NSString *title))setTitle;
- (ZJAlertBuilder *(^)(NSString *message))setMessage;
- (ZJAlertBuilder *(^)(NSString *confirmActionTitle))setConfirmActionTitle;
- (ZJAlertBuilder *(^)(NSString *cancelActionTitle))setCancelActionTitle;
- (ZJAlertBuilder *(^)(NSString *placeholder))addTextField;
- (ZJAlertBuilder *(^)())addConfirmActionObserver;//添加finish按钮点击事件的监听

/**
 点击取消按钮的回调
 @param handler 回调block的实现
 */
- (void)addCancelActionHandler:(void(^)(UIAlertAction *action))handler;

/**
 alert的显示和销毁
 */
- (ZJAlertBuilder *(^)())show;
- (ZJAlertBuilder *(^)())dismiss;

@end
