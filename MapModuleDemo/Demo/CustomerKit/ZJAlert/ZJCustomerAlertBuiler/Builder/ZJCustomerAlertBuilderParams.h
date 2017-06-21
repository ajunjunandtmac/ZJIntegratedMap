//
//  ZJCustomerAlertBuilderParams.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/9.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 部件存储类，保存用户构建过程中传入的参数,其实就是界面的模型对象
 只不过模型对象的参数初始化时通过构建器的链式调用来完成的
 */
@interface ZJCustomerAlertBuilderParams : NSObject
@property(nonatomic,strong)UIViewController *context;
@property(nonatomic,strong)UIViewController *target;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSDictionary *titleAttributes;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)NSDictionary *messageAttributes;
@property(nonatomic,copy)NSString *confirmActionTitle;
@property(nonatomic,strong)NSDictionary *confirmActionTitleAttributes;
@property(nonatomic,strong)UIColor *confirmButtonColor;
@property(nonatomic,copy)NSString *cancelActionTitle;
@property(nonatomic,strong)NSDictionary *cancelActionTitleAttributes;
@property(nonatomic,strong)UIColor *cancelButtonColor;
@property(nonatomic,copy)void(^confirmActionHandler)(NSString *inputText);
@property(nonatomic,copy)void(^cancelActionHandler)();
@property(nonatomic,copy)void (^textFieldConfigurationHandler)(UITextField *textField);
@property(nonatomic,copy)NSString *inputText;
- (instancetype)initWithContext:(UIViewController *)context;
@end
