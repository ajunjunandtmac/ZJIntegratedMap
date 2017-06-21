//
//  ZJAlertComponentFrameTool.m
//  构建者模式的自定义alert
//
//  Created by jiale on 2017/6/12.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJAlertComponentFrameTool.h"
#import "NSString+AutoCountLabelSize.h"
static CGFloat const marginY = 10.0f;
static CGFloat const marginX = 10.0f;
static CGSize const defaultButtonSize = {70.0f,30.0f};
@implementation ZJAlertComponentFrameTool
- (CGFloat)countAlertHeightWithAlertWidth:(CGFloat)width params:(ZJCustomerAlertBuilderParams *)params
{
    _params = params;
    
    CGSize titleS = [params.title sizeWithFontForSingleRow:params.titleAttributes[NSFontAttributeName]];
    CGFloat titleX = (width-titleS.width)*0.5;
    CGFloat titleY = 2 * marginY;
    _titleRect = CGRectMake(titleX, titleY, titleS.width, titleS.height);
    
    CGFloat rowMaxWidth = width-2*marginX;
    CGSize messageS = [params.message sizeWithFontforMultiRows:params.messageAttributes[NSFontAttributeName] rowMaxWidth:rowMaxWidth];
    CGFloat messageX = marginX;
    CGFloat messageY = CGRectGetMaxY(_titleRect)+marginY;
    _messageRect = CGRectMake(messageX, messageY, rowMaxWidth,messageS.height);
    
    CGFloat textFieldH = 30.0f;
    CGFloat textFieldW = width - marginX*2;
    CGFloat textFieldX = marginX;
    CGFloat textFieldY = CGRectGetMaxY(_messageRect)+marginY*2;
    _textFieldRect = CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH);
    if (params.textFieldConfigurationHandler==nil) {
        _textFieldRect = CGRectNull;
    }
    
    CGFloat cancelButtonX = 0.0;
    CGFloat cancelButtonY = 0.0;
    CGFloat confirmButtonX = 0.0;
    CGFloat confirmButtonY = 0.0;
    CGFloat alertH;

    BOOL hasCancelButton = params.cancelActionTitle&&![params.cancelActionTitle isEmptyString];
    BOOL hasConfirmButton = params.confirmActionTitle&&![params.confirmActionTitle isEmptyString];
    if (params.textFieldConfigurationHandler) {
        if (hasCancelButton&&hasConfirmButton) {
            cancelButtonX = (width*0.5-defaultButtonSize.width)*0.5;
            confirmButtonX = width*0.5+(width*0.5-defaultButtonSize.width)*0.5;
            cancelButtonY = CGRectGetMaxY(_textFieldRect)+marginY*2;
            confirmButtonY = cancelButtonY;
            _cancelButtonRect = CGRectMake(cancelButtonX, cancelButtonY, defaultButtonSize.width, defaultButtonSize.height);
            _confirmButtonRect = CGRectMake(confirmButtonX, confirmButtonY, defaultButtonSize.width, defaultButtonSize.height);
            alertH = CGRectGetMaxY(_cancelButtonRect)+marginY*2;
        }
        else if (hasCancelButton){
            cancelButtonX = (width - defaultButtonSize.width)*0.5;
            cancelButtonY = CGRectGetMaxY(_textFieldRect)+marginY*2;
            _cancelButtonRect = CGRectMake(cancelButtonX, cancelButtonY, defaultButtonSize.width, defaultButtonSize.height);
            _confirmButtonRect = CGRectNull;
            alertH = CGRectGetMaxY(_cancelButtonRect)+marginY*2;
        }
        else{
            confirmButtonX = (width - defaultButtonSize.width)*0.5;
            confirmButtonY = CGRectGetMaxY(_textFieldRect)+marginY*2;
            _confirmButtonRect = CGRectMake(confirmButtonX, confirmButtonY, defaultButtonSize.width, defaultButtonSize.height);
            _cancelButtonRect = CGRectNull;
            alertH = CGRectGetMaxY(_confirmButtonRect)+marginY*2;
        }
    }
    else{
        if (hasCancelButton&&hasConfirmButton) {
            cancelButtonX = (width*0.5-defaultButtonSize.width)*0.5;
            confirmButtonX = width*0.5+(width*0.5-defaultButtonSize.width)*0.5;
            cancelButtonY = CGRectGetMaxY(_messageRect)+marginY*2;
            confirmButtonY = cancelButtonY;
            _cancelButtonRect = CGRectMake(cancelButtonX, cancelButtonY, defaultButtonSize.width, defaultButtonSize.height);
            _confirmButtonRect = CGRectMake(confirmButtonX, confirmButtonY, defaultButtonSize.width, defaultButtonSize.height);
            alertH = CGRectGetMaxY(_cancelButtonRect)+marginY*2;
        }
        else if (hasCancelButton){
            cancelButtonX = (width - defaultButtonSize.width)*0.5;
            cancelButtonY = CGRectGetMaxY(_messageRect)+marginY*2;
            _cancelButtonRect = CGRectMake(cancelButtonX, cancelButtonY, defaultButtonSize.width, defaultButtonSize.height);
            _confirmButtonRect = CGRectNull;
            alertH = CGRectGetMaxY(_cancelButtonRect)+marginY*2;
        }
        else{
            confirmButtonX = (width - defaultButtonSize.width)*0.5;
            confirmButtonY = CGRectGetMaxY(_messageRect)+marginY*2;
            _confirmButtonRect = CGRectMake(confirmButtonX, confirmButtonY, defaultButtonSize.width, defaultButtonSize.height);
            _cancelButtonRect = CGRectNull;
            alertH = CGRectGetMaxY(_confirmButtonRect)+marginY*2;
        }
    }
    
    CGFloat forkViewH = 43.0f;
    CGFloat forkViewW = forkViewH;
    CGFloat forkViewX = width-forkViewH-10;
    CGFloat forkViewY = 0;
    _forkRegion = CGRectMake(forkViewX, forkViewY, forkViewW, forkViewH);
    
    CGFloat backViewX = 0;
    CGFloat backViewY = forkViewH;
    CGFloat backViewH = alertH;
    CGFloat backViewW = width;
    _backVIewRect = CGRectMake(backViewX, backViewY, backViewW, backViewH);
    
    alertH += forkViewH;
    return alertH;
}
@end
