//
//  RefreshCoverView.m
//  Tea
//
//  Created by jiale on 16/7/13.
//  Copyright © 2016年 jiale. All rights reserved.
//

#import "RefreshCoverView.h"
#import "Masonry.h"
#import "GQCircleLoadView.h"
@interface RefreshCoverView ()
@property(nonatomic,weak)UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic,weak)UIView *refreshAgainBackView;
@property(nonatomic,copy)serverErrorHandler handler;
@property(nonatomic,weak)GQCircleLoadView *loadingView;
//@property(nonatomic,assign)UIEdgeInsets edgeToView;
//@property(nonatomic,weak)UIView *fatherView;
@end
static RefreshCoverView *cover_static = nil;
@implementation RefreshCoverView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        GQCircleLoadView *loadingView = [[GQCircleLoadView alloc] init];
        [self addSubview:loadingView];
        _loadingView = loadingView;
        
        UIView *refreshAgainBackView = [[UIView alloc] init];
        refreshAgainBackView.userInteractionEnabled = YES;
        refreshAgainBackView.hidden = YES;
        [self addSubview:refreshAgainBackView];
        [refreshAgainBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(200);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshAgain)];
        [refreshAgainBackView addGestureRecognizer:tap];
        
        UIImageView *refreshImageView = [[UIImageView alloc] init];
        refreshImageView.image = [UIImage imageNamed:@"refresh_again"];
        [refreshAgainBackView addSubview:refreshImageView];
        [refreshImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(refreshAgainBackView);
            make.centerY.equalTo(refreshAgainBackView).with.offset(-10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(35);
        }];
        self.refreshAgainBackView = refreshAgainBackView;
        
        UILabel *refreshTipLabel = [[UILabel alloc] init];
        refreshTipLabel.textAlignment = NSTextAlignmentCenter;
        refreshTipLabel.font = [UIFont systemFontOfSize:12];
        refreshTipLabel.text = @"服务器开小差了，点击重新刷新";
        [refreshAgainBackView addSubview:refreshTipLabel];
        [refreshTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(refreshImageView.mas_bottom).with.offset(10);
            make.left.and.right.equalTo(refreshAgainBackView);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
}


- (void)startRefreshing
{
    self.hidden = NO;
}

- (void)stopRefreshing
{
    [_loadingView removeFromSuperview];
    self.hidden = YES;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)stopRefreshingDueToServerErrorWithHandler:(serverErrorHandler)handler
{
    [_loadingView removeFromSuperview];
    self.backgroundColor = [UIColor whiteColor];
    _refreshAgainBackView.hidden = NO;
    self.handler = handler;
}

- (void)refreshAgain
{
    _refreshAgainBackView.hidden = YES;
    if (_handler != nil) {
        self.handler();
    };
}

+ (void)beginRefreshingAndAddToView:(UIView *)view
{
    [self beginRefreshingWithEdgeToView:UIEdgeInsetsMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor] addToView:view];
}

+ (void)beginRefreshingWithEdgeToView:(UIEdgeInsets)edgeToView backgroundColor:(UIColor *)backgroundColor addToView:(UIView *)view
{
    if (cover_static) {//指向新的coverView前先移除掉上一个coverView，不然旧的cover永远加在view上，移除不掉了。
        [cover_static removeFromSuperview];
    }
    cover_static = [[self alloc] init];

    cover_static.hidden = NO;
    cover_static.backgroundColor = backgroundColor;
    [view addSubview:cover_static];
    [view bringSubviewToFront:cover_static];
    [cover_static mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).with.insets(edgeToView);
    }];
}


+ (void)endRefreshing
{
    [cover_static.loadingView removeFromSuperview];
    [cover_static removeFromSuperview];
    cover_static = nil;
}

+ (void)endRefreshingDueToServerErrorWithHandler:(serverErrorHandler)handler
{
    [cover_static.loadingView removeFromSuperview];
    cover_static.refreshAgainBackView.hidden = NO;
    cover_static.handler = handler;
}


@end
