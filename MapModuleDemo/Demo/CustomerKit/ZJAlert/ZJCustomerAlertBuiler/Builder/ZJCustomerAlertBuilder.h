//
//  ZJCustomerAlertBuilder.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/6.
//  Copyright © 2017年 jiale. All rights reserved.
//  构建自定义alertController

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ZJCustomerAlertConfirmActionHandler)(NSString *inputText);

@interface ZJCustomerAlertBuilder : NSObject

/**
 因为涉及到有textField，设计的繁琐了一点，如果想得到确认按钮以及输入框的回调，请实现它
 */
@property(nonatomic,copy)ZJCustomerAlertConfirmActionHandler confirmActionHandler;

/**
 builder初始化方法

 @param context 当前控制器
 @return builder实例
 */
+ (ZJCustomerAlertBuilder *)builderWithContext:(UIViewController *)context;

/**
 链式调用构建Alert
 */
- (ZJCustomerAlertBuilder *(^)(NSString *title))setTitle;
- (ZJCustomerAlertBuilder *(^)(NSDictionary *titleAttributes))setTitleAttributes;
- (ZJCustomerAlertBuilder *(^)(NSString *message))setMessage;
- (ZJCustomerAlertBuilder *(^)(NSDictionary *messageAttributes))setMessageAttributes;
- (ZJCustomerAlertBuilder *(^)(NSString *confirmActionTitle))setConfirmActionTitle;
- (ZJCustomerAlertBuilder *(^)(NSDictionary *confirmActionTitleAttributes))setConfirmActionTitleAttributes;
- (ZJCustomerAlertBuilder *(^)(UIColor *confirmButtonColor))setConfirmButtonColor;
- (ZJCustomerAlertBuilder *(^)(NSString *cancelActionTitle))setCancelActionTitle;
- (ZJCustomerAlertBuilder *(^)(NSDictionary *cancelActionTitleAttributes))setCancelActionTitleAttributes;
- (ZJCustomerAlertBuilder *(^)(UIColor *cancelButtonColor))setCancelButtonColor;
- (ZJCustomerAlertBuilder *(^)(NSString *placeholder))addTextField;
- (ZJCustomerAlertBuilder *(^)())addConfirmActionObserver;//添加finish按钮点击事件的监听

/**
 点击取消按钮的回调
 @param handler 回调block的实现
 */
- (void)addCancelActionHandler:(void(^)())handler;


/**
 alert的显示和销毁
 */
- (ZJCustomerAlertBuilder *(^)())show;
- (ZJCustomerAlertBuilder *(^)())dismiss;

@end
