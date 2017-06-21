//
//  PoiDetailView.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/18.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "PoiDetailView.h"
#import <QMUIKit/QMUIKit.h>
#import "QDCommonUI.h"
#import "QDUIHelper.h"
#import "PoiDetailViewFrameTool.h"
@interface PoiDetailView ()
@property(nonatomic,strong)UIView *infoBackView;
@property(nonatomic,strong)QMUIButton *goThereButton;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UIButton *distanceShowButton;
@property(nonatomic,strong)UIButton *arrowDownButton;
@property(nonatomic,weak)id<PoiDetailViewDelegate>delegate;
@end

@implementation PoiDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    self.infoBackView = [UIView new];
    self.infoBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_infoBackView];
    
    self.goThereButton = [[QMUIButton alloc] init];
    self.goThereButton.adjustsImageTintColorAutomatically = NO;
    self.goThereButton.adjustsTitleTintColorAutomatically = NO;
    self.goThereButton.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
    self.goThereButton.spacingBetweenImageAndTitle = 8;
    [self.goThereButton setImage:UIImageMake(@"car") forState:UIControlStateNormal];
    [self.goThereButton setTitle:@"到这去" forState:UIControlStateNormal];
    [self.goThereButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.goThereButton.titleLabel.font = UIFontMake(9);
    [self.goThereButton setBackgroundColor:UIColorMake(87, 155, 248)];
    [self.goThereButton addTarget:self action:@selector(startRoute) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goThereButton];
    
    self.arrowDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowDownButton setBackgroundImage:UIImageMake(@"arrowdown") forState:UIControlStateNormal];
    [self.arrowDownButton addTarget:self action:@selector(arrowDownClick) forControlEvents:UIControlEventTouchUpInside];
    [self.infoBackView addSubview:self.arrowDownButton];
    
    self.titleLabel = [UILabel new];
    [self.infoBackView addSubview:_titleLabel];
    
    self.addressLabel = [UILabel new];
    self.addressLabel.textColor = UIColorGray8;
    self.addressLabel.numberOfLines = 0;
    [self.infoBackView addSubview:_addressLabel];
    
    self.distanceShowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.distanceShowButton.userInteractionEnabled = NO;
    [self.distanceShowButton setTitleColor:UIColorGray8 forState:UIControlStateNormal];
    [self.distanceShowButton setImage:UIImageMake(@"location-arrow") forState:UIControlStateNormal];
    self.distanceShowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.infoBackView addSubview:_distanceShowButton];
}

- (void)configureWithPoiDetailViewTool:(PoiDetailViewFrameTool *)tool delegate:(id<PoiDetailViewDelegate>)delegate
{
    _tool = tool;
    _delegate = delegate;
    id<IPoiDetailSearchResult> result = tool.poiDetailInfo;
    self.titleLabel.text = result.getName;
    self.addressLabel.text = result.address;
    [self.distanceShowButton setTitle:[NSString stringWithFormat:@"%.2lf米",result.getDistanceFromUserLocation] forState:UIControlStateNormal];
    
    self.titleLabel.font = titleLabelFont;
    self.addressLabel.font = addressLabelFont;
    self.distanceShowButton.titleLabel.font = distanceShowLabelFont;
    
    self.goThereButton.frame = tool.goThereButtonRect;
    self.goThereButton.layer.masksToBounds = YES;
    self.goThereButton.layer.cornerRadius = CGRectGetWidth(tool.goThereButtonRect)*0.5;
    
    self.infoBackView.frame = tool.infoBackViewRect;
    self.arrowDownButton.frame = tool.arrowDownButtonRect;
    self.titleLabel.frame = tool.titleLabelRect;
    self.addressLabel.frame = tool.addressLabelRect;
    self.distanceShowButton.frame = tool.distanceShowButtonRect;

}

- (void)arrowDownClick
{
    if ([_delegate respondsToSelector:@selector(arrowDownButtonClicked)]) {
        [_delegate arrowDownButtonClicked];
    }
}

- (void)startRoute
{
    if ([_delegate respondsToSelector:@selector(goThereButtonClickedWithPoiInfo:)]) {
        [_delegate goThereButtonClickedWithPoiInfo:_tool.poiDetailInfo];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
