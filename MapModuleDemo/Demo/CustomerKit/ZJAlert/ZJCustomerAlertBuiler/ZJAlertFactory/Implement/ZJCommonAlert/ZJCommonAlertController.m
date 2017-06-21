//
//  ZJCommonAlertController.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/12.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJCommonAlertController.h"
#import "ZJCommonAlertView.h"
#import "ZJAlertComponentFrameTool.h"
#import "ZJAlertControllerProtocol.h"
#import "ZJTransitioningDelegate.h"
@interface ZJCommonAlertController ()<ZJCommonAlertViewDelegate,ZJAlertControllerProtocol>
@property(nonatomic,strong)ZJCustomerAlertBuilderParams *params;
@property(nonatomic,weak)UIImageView *backgroundImageView;
@property(nonatomic,weak)ZJCommonAlertView *alert;
@property(nonatomic,assign)CGFloat alertMoveDistanceWhenKeyboardShow;
@property(nonatomic,assign)CGFloat animateDuration;
@property(nonatomic,weak)UIView *cover;
@end

@implementation ZJCommonAlertController
- (instancetype)initWithParams:(ZJCustomerAlertBuilderParams *)params
{
    self = [super init];
    if (self) {
        _params = params;
        //self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        //self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//前一画面逐渐消失的同时，后一画面逐渐显示
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = [ZJTransitioningDelegate delegate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInitCover];
    [self commonInitContentView];
}

- (void)commonInitCover
{
    UIView *cover = [UIView new];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0f;
    [self.view addSubview:cover];
    cover.frame = self.view.bounds;
    _cover = cover;
}

- (void)commonInitContentView
{
    ZJAlertComponentFrameTool *tool = [[ZJAlertComponentFrameTool alloc] init];
    CGFloat alertViewW = 200.0f;
    CGFloat h = [tool countAlertHeightWithAlertWidth:alertViewW params:_params];
    CGFloat x = (self.view.bounds.size.width - alertViewW)*0.5;
    CGFloat y = (self.view.bounds.size.height - h)*0.5;
    CGRect frame = CGRectMake(x, y, alertViewW, h);
    ZJCommonAlertView *alert = [[ZJCommonAlertView alloc] initWithFrame:frame];
    [alert configureWithFrameTool:tool delegate:self];
    [self.view addSubview:alert];
    _alert = alert;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardFrameWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardFrameWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - ZJCommonAlertViewDelegate
- (void)ZJCommonAlertView:(UIView *)alertView didClickCancelBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (_params.cancelActionHandler) {
            _params.cancelActionHandler();
        }
    }];
    
}

- (void)ZJCommonAlertView:(UIView *)alertView didClickConfirmBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (_params.confirmActionHandler) {
            _params.confirmActionHandler(_params.inputText);
        }
    }];
}

- (void)handleKeyboardFrameWillShow:(NSNotification *)notif
{
    
    NSDictionary *dic = notif.userInfo;
    _animateDuration = [dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect keyboardBeginFrame = [dic[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect keyboardEndFrame = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat keyboardH= keyboardEndFrame.size.height;
    CGFloat alertBottomToScreenBottomDistance = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(_alert.frame)-20;
    _alertMoveDistanceWhenKeyboardShow = keyboardH>alertBottomToScreenBottomDistance?alertBottomToScreenBottomDistance-keyboardH:0;
    [self animateAlertMoveWithDistance:_alertMoveDistanceWhenKeyboardShow duration:_animateDuration];
}

- (void)handleKeyboardFrameWillHide:(NSNotification *)notif
{
    [self animateAlertMoveWithDistance:-(_alertMoveDistanceWhenKeyboardShow) duration:_animateDuration];
}

- (void)animateAlertMoveWithDistance:(CGFloat)moveDistance duration:(CGFloat)animateDuration
{
    [UIView animateWithDuration:animateDuration animations:^{
        _alert.transform = CGAffineTransformTranslate(_alert.transform, 0, moveDistance);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - ZJAlertControllerProtocol
- (UIView *)getCover
{
    return _cover;
}

- (UIView *)getContentView
{
    return _alert;
}
@end
