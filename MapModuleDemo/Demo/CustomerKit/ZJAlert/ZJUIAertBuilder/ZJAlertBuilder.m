//
//  ZJAlertBuilder.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/6.
//  Copyright © 2017年 jiale. All rights reserved.
//
#import "ZJAlertBuilder.h"

/**
 部件存储类，保存用户构建过程中传入的参数
 */
@interface ZJAlertBuilderParams : NSObject
@property(nonatomic,strong)UIViewController *context;
@property(nonatomic,strong)UIAlertController *target;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *confirmActionTitle;
@property(nonatomic,copy)NSString *cancelActionTitle;
@property(nonatomic,copy)void(^confirmActionHandler)(UIAlertAction *action);
@property(nonatomic,copy)void(^cancelActionHandler)(UIAlertAction *action);
@property(nonatomic,copy)void (^textFieldConfigurationHandler)(UITextField *textField);
@property(nonatomic,copy)NSString *inputText;
@property(nonatomic,weak)UIAlertAction *confirmAction;
- (instancetype)initWithContext:(UIViewController *)context;
@end

@implementation ZJAlertBuilderParams
- (instancetype)initWithContext:(UIViewController *)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}
@end


/**
 构建类：接收用户输入的参数并根据参数构建alert，用户输入的参数不同，alert的UI就不同
 */
@interface ZJAlertBuilder ()
@property(nonatomic,strong)ZJAlertBuilderParams *builderParams;
@end

@implementation ZJAlertBuilder

+ (ZJAlertBuilder *)builderWithContext:(UIViewController *)context
{
    return [[self alloc] initWithContext:context];
}

- (instancetype)initWithContext:(UIViewController *)context
{
    self = [super init];
    if (self) {
        _builderParams = [[ZJAlertBuilderParams alloc] initWithContext:context];
    }
    return self;
}

- (ZJAlertBuilder *(^)(NSString *title))setTitle
{
    return ^(NSString *title){
        _builderParams.title = title;
        return self;
    };
}

- (ZJAlertBuilder *(^)(NSString *message))setMessage
{
    return ^(NSString *message){
        _builderParams.message = message;
        return self;
    };
}

- (ZJAlertBuilder *(^)(NSString *confirmActionTitle))setConfirmActionTitle
{
    return ^(NSString *confirmTitle){
        _builderParams.confirmActionTitle = confirmTitle;
        return self;
    };
}

- (ZJAlertBuilder *(^)(NSString *cancelActionTitle))setCancelActionTitle
{
    return ^(NSString *cancelActionTitle){
        _builderParams.cancelActionTitle = cancelActionTitle;
        return self;
    };
}

- (ZJAlertBuilder *(^)(NSString *placeholder))addTextField
{
    return ^(NSString *placeholder){
        void (^configurationHandler)(UITextField *textField) = ^(UITextField *textField){
            textField.placeholder = placeholder;
            [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        };
        _builderParams.textFieldConfigurationHandler = configurationHandler;
        return self;
    };
}

- (ZJAlertBuilder *(^)())addConfirmActionObserver
{
    return ^(){
        void(^confirmActionHandler)(UIAlertAction *action) = ^(UIAlertAction *action){
            if (self.confirmActionHandler) {
                self.confirmActionHandler(action, _builderParams.inputText);
            }
        };
        _builderParams.confirmActionHandler = confirmActionHandler;
        return self;
    };
}

- (void)addCancelActionHandler:(void(^)(UIAlertAction *action))handler
{
    _builderParams.cancelActionHandler = handler;
}

- (ZJAlertBuilder *(^)())build
{
    return ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:_builderParams.title message:_builderParams.message preferredStyle:UIAlertControllerStyleAlert];
        if ([_builderParams.confirmActionTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length!=0) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:_builderParams.confirmActionTitle style:UIAlertActionStyleDefault handler:_builderParams.confirmActionHandler];
            [alert addAction:action];
            action.enabled = [_builderParams.inputText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0;
            _builderParams.confirmAction = action;
            
        }
        
        if ([_builderParams.cancelActionTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length!=0) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:_builderParams.cancelActionTitle style:UIAlertActionStyleCancel handler:_builderParams.cancelActionHandler];
            [alert addAction:action];
        }
        
        if (_builderParams.textFieldConfigurationHandler) {
            [alert addTextFieldWithConfigurationHandler:_builderParams.textFieldConfigurationHandler];
        }
        _builderParams.target = alert;

        return self;
    };
}

- (ZJAlertBuilder *(^)())show
{
    return ^(){
        self.build();
        [_builderParams.context presentViewController:_builderParams.target animated:YES completion:nil];
        return self;
    };
}

- (ZJAlertBuilder *(^)())dismiss
{
    return ^(){
        [_builderParams.target dismissViewControllerAnimated:YES completion:nil];
        return self;
    };
}

#pragma mark - UITextFieldDelegate
- (void)textChanged:(UITextField *)textField
{
    _builderParams.inputText = textField.text;
    if (_builderParams.confirmAction) {
        _builderParams.confirmAction.enabled = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length!=0;
    }
}

@end
