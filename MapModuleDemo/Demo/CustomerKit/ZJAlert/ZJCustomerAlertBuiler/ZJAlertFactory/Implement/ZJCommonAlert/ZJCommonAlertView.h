//
//  ZJCommonAlertView.h
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/12.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJAlertComponentFrameTool.h"
@protocol ZJCommonAlertViewDelegate<NSObject>
//- (void)ZJCommonAlertView:(UIView *)alertView didBeginEditing:(UITextField *)textField;
//- (void)ZJCommonAlertView:(UIView *)alertView didEndEditing:(UITextField *)textField;
- (void)ZJCommonAlertView:(UIView *)alertView didClickConfirmBtn:(UIButton *)sender;
- (void)ZJCommonAlertView:(UIView *)alertView didClickCancelBtn:(UIButton *)sender;
@end

@interface ZJCommonAlertView : UIView
- (void)configureWithFrameTool:(ZJAlertComponentFrameTool *)tool delegate:(id<ZJCommonAlertViewDelegate>)delegate;
@end
