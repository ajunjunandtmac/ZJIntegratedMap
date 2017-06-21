//
//  ZJCommonAlertView.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/12.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJCommonAlertView.h"
#import "UIButton+ZJExtension.h"
#import "NSString+AutoCountLabelSize.h"
@interface ZJCommonAlertView ()<UITextFieldDelegate>
@property(nonatomic,weak)UILabel *title;
@property(nonatomic,weak)UILabel *message;
@property(nonatomic,weak)UITextField *textField;
@property(nonatomic,weak)UIButton *cancelButton;
@property(nonatomic,weak)UIButton *confirmButton;
@property(nonatomic,weak)UIView *back;
@property(nonatomic,weak)id<ZJCommonAlertViewDelegate>delegate;
@property(nonatomic,assign)CGRect forkViewRect;
@property(nonatomic,strong)ZJCustomerAlertBuilderParams *params;
@end

@implementation ZJCommonAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgIV = [[UIImageView alloc] init];
        UIImage *bgImage = [UIImage imageNamed:@"bomb-box"];
        UIImage *resizableImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(50, 10, 10, 50) resizingMode:UIImageResizingModeTile];
        bgIV.image = resizableImage;
        [self addSubview:bgIV];
        bgIV.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        UIView *back = [UIView new];
        back.backgroundColor = [UIColor clearColor];
        [self addSubview:back];
        _back = back;
        
        UILabel *title = [UILabel new];
        [back addSubview:title];
        title.textAlignment = NSTextAlignmentCenter;
        _title = title;
        
        UILabel *message = [UILabel new];
        [back addSubview:message];
        message.textAlignment = NSTextAlignmentCenter;
        _message = message;
        
        UITextField *tf = [UITextField new];
        tf.backgroundColor = [UIColor whiteColor];
        tf.delegate = self;
        tf.returnKeyType = UIReturnKeyDone;
        [back addSubview:tf];
        [tf addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField = tf;
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [back addSubview:cancelButton];
        cancelButton.layer.masksToBounds = YES;
        cancelButton.layer.cornerRadius = 5.0f;
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = cancelButton;
        
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [back addSubview:confirmButton];
        confirmButton.layer.masksToBounds = YES;
        confirmButton.layer.cornerRadius = 5.0f;
        [confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton = confirmButton;
    }
    return self;
}

- (void)configureWithFrameTool:(ZJAlertComponentFrameTool *)tool delegate:(id<ZJCommonAlertViewDelegate>)delegate
{
    _delegate = delegate;
    _back.frame = tool.backVIewRect;
    _title.frame = tool.titleRect;
    _message.frame = tool.messageRect;
    if (!CGRectIsNull(tool.textFieldRect)) {
        _textField.frame = tool.textFieldRect;
        _textField.hidden = NO;
    }
    else{
        _textField.hidden = YES;
    }
    
    if (!CGRectIsNull(tool.cancelButtonRect)) {
        _cancelButton.frame = tool.cancelButtonRect;
        _cancelButton.hidden = NO;
    }
    else{
        _cancelButton.hidden = YES;
    }
    
    if (!CGRectIsNull(tool.confirmButtonRect)) {
        _confirmButton.frame = tool.confirmButtonRect;
        _confirmButton.hidden = NO;
    }
    else{
        _confirmButton.hidden = YES;
    }
    _forkViewRect = tool.forkRegion;
    
    ZJCustomerAlertBuilderParams *params = tool.params;
    _params = params;
    _title.text = params.title;
    _title.font = params.titleAttributes[NSFontAttributeName];
    _title.textColor = params.titleAttributes[NSForegroundColorAttributeName];
    
    _message.text = params.message;
    _message.font = params.messageAttributes[NSFontAttributeName];
    _message.textColor = params.messageAttributes[NSForegroundColorAttributeName];
    
    //如果用户添加了textField,确定按钮的状态和text输入关联
    if (params.textFieldConfigurationHandler) {
        params.textFieldConfigurationHandler(_textField);
        _confirmButton.enabled = _textField.text!=nil&&![_textField.text isEmptyString];
    }
    
    _cancelButton.titleLabel.font = params.cancelActionTitleAttributes[NSFontAttributeName];
    [_cancelButton setBackgroundColor:params.cancelButtonColor];
    [_cancelButton setTitle:params.cancelActionTitle forState:UIControlStateNormal];
    [_cancelButton setTitleColor:params.cancelActionTitleAttributes[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    
    _confirmButton.titleLabel.font = params.confirmActionTitleAttributes[NSFontAttributeName];
    [_confirmButton setBackgroundColor:params.confirmButtonColor forState:UIControlStateNormal];
    [_confirmButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_confirmButton setTitle:params.confirmActionTitle forState:UIControlStateNormal];
    [_confirmButton setTitle:params.confirmActionTitle forState:UIControlStateDisabled];
    [_confirmButton setTitleColor:params.confirmActionTitleAttributes[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
}

- (void)confirm:(UIButton *)sender
{
    if (_params.textFieldConfigurationHandler) {//存在textField
        [_textField resignFirstResponder];
    }
    [_delegate ZJCommonAlertView:self didClickConfirmBtn:sender];
}

- (void)cancel:(UIButton *)sender
{
    if (_params.textFieldConfigurationHandler) {//存在textField
        [_textField resignFirstResponder];
    }
    [_delegate ZJCommonAlertView:self didClickCancelBtn:sender];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self];
    if (CGRectContainsPoint(_forkViewRect, p)) {
        [_delegate ZJCommonAlertView:self didClickCancelBtn:nil];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _params.inputText = textField.text;
}

- (void)textChanged:(UITextField *)textField
{
    _confirmButton.enabled = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length!=0;

}

@end
