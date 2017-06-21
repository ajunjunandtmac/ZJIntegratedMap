//
//  ZJAlertBuilder.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/6.
//  Copyright © 2017年 jiale. All rights reserved.
//  
#import "ZJCustomerAlertBuilder.h"
#import "ZJCustomerAlertBuilderParams.h"
#import "ZJAlertEngine.h"
/**
 构建类：接收用户输入的参数并根据参数构建alert，用户输入的参数不同，alert的UI就不同
 */
@interface ZJCustomerAlertBuilder ()
@property(nonatomic,strong)ZJCustomerAlertBuilderParams *builderParams;
@end

@implementation ZJCustomerAlertBuilder

+ (ZJCustomerAlertBuilder *)builderWithContext:(UIViewController *)context
{
    return [[self alloc] initWithContext:context];
}

- (instancetype)initWithContext:(UIViewController *)context
{
    self = [super init];
    if (self) {
        _builderParams = [[ZJCustomerAlertBuilderParams alloc] initWithContext:context];
    }
    return self;
}

- (ZJCustomerAlertBuilder *(^)(NSString *title))setTitle
{
    return ^(NSString *title){
        _builderParams.title = title;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(NSDictionary *titleAttributes))setTitleAttributes
{
    return ^(NSDictionary *titleAttributes){
        _builderParams.titleAttributes = titleAttributes;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(NSString *message))setMessage
{
    return ^(NSString *message){
        _builderParams.message = message;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(NSDictionary *messageAttributes))setMessageAttributes
{
    return ^(NSDictionary *messageAttributes){
        _builderParams.messageAttributes = messageAttributes;
        return self;
    };
}


- (ZJCustomerAlertBuilder *(^)(NSString *confirmActionTitle))setConfirmActionTitle
{
    return ^(NSString *confirmTitle){
        _builderParams.confirmActionTitle = confirmTitle;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(NSDictionary *confirmActionTitleAttributes))setConfirmActionTitleAttributes
{
    return ^(NSDictionary *confirmActionTitleAttributes){
        _builderParams.confirmActionTitleAttributes = confirmActionTitleAttributes;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(UIColor *confirmButtonColor))setConfirmButtonColor
{
    return ^(UIColor *confirmButtonColor){
        _builderParams.confirmButtonColor = confirmButtonColor;
        return self;
    };
}


- (ZJCustomerAlertBuilder *(^)(NSString *cancelActionTitle))setCancelActionTitle
{
    return ^(NSString *cancelActionTitle){
        _builderParams.cancelActionTitle = cancelActionTitle;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(NSDictionary *cancelActionTitleAttributes))setCancelActionTitleAttributes
{
    return ^(NSDictionary *cancelActionTitleAttributes){
        _builderParams.cancelActionTitleAttributes = cancelActionTitleAttributes;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(UIColor *cancelButtonColor))setCancelButtonColor
{
    return ^(UIColor *cancelButtonColor){
        _builderParams.cancelButtonColor = cancelButtonColor;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)(NSString *placeholder))addTextField
{
    return ^(NSString *placeholder){
        void (^configurationHandler)(UITextField *textField) = ^(UITextField *textField){
            textField.placeholder = placeholder;
        };
        _builderParams.textFieldConfigurationHandler = configurationHandler;
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)())addConfirmActionObserver
{
    return ^(){
        void(^confirmActionHandler)(NSString *) = ^(NSString *inputText){
            if (self.confirmActionHandler) {
                self.confirmActionHandler(inputText);
            }
        };
        _builderParams.confirmActionHandler = confirmActionHandler;
        return self;
    };
}

- (void)addCancelActionHandler:(void(^)())handler
{
    _builderParams.cancelActionHandler = handler;
}

- (ZJCustomerAlertBuilder *(^)())build
{
    return ^(){
        ZJAlertEngine *engine = [ZJAlertEngine engine];
        id<ZJAlertFactoryProtocol>factory = [engine alertControllerFactoryWithType:ZJAlertFactoryTypeCommon params:_builderParams];
        _builderParams.target = [factory getAlertController];
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)())show
{
    return ^(){
        self.build();
        [_builderParams.context presentViewController:_builderParams.target animated:YES completion:nil];
        return self;
    };
}

- (ZJCustomerAlertBuilder *(^)())dismiss
{
    return ^(){
        [_builderParams.target dismissViewControllerAnimated:YES completion:nil];
        return self;
    };
}

@end
