//
//  ZJSegmentedView.m
//  Family
//
//  Created by jiale on 2017/4/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJSegmentedView.h"
#import "UIView+JHChainableAnimations.h"
#define labelButtonFont [UIFont fontWithName:@"PingFangTC-Medium" size:14]
#define APPThemeColor  [UIColor colorWithRed:62/255.0 green:63/255.0 blue:165/255.0 alpha:1]
static CGFloat const animationTime = .2f;
@interface ZJSegmentedView ()
@property(nonatomic,strong)NSArray<NSString *> *titles;
@property(nonatomic,strong)UIView *bottomSeperator;
@property(nonatomic,strong)NSArray<UIView *> *segments;
@property(nonatomic,strong)NSArray<UIButton *> *labelButtons;
@property(nonatomic,weak)id<ZJSegmentedViewDelegate>delegate;
@property(nonatomic,assign)NSInteger lastIndex;
@property(nonatomic,assign)CGFloat bottomLinePaddingToSegment;
@property(nonatomic,assign)BOOL animatingStart;
@end

@implementation ZJSegmentedView
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles delegate:(id<ZJSegmentedViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _titles = titles;
        _lastIndex = 0;
        NSMutableArray *segments = [NSMutableArray array];
        NSMutableArray *labelButtons = [NSMutableArray array];
        for (int i=0;i<_titles.count;i++) {
            NSString *title = _titles[i];
            UIView *segment = [UIView new];
            segment.userInteractionEnabled = YES;
            segment.backgroundColor = [UIColor clearColor];
            segment.tag = i;
            UITapGestureRecognizer *segmentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentTap:)];
            [segment addGestureRecognizer:segmentTap];
            [self addSubview:segment];

            UIButton *labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            labelButton.backgroundColor = [UIColor clearColor];
            labelButton.titleLabel.font = labelButtonFont;
            labelButton.userInteractionEnabled = NO;
            labelButton.selected = (i==0);
            [labelButton setTitle:title forState:UIControlStateNormal];
            [labelButton setTitle:title forState:UIControlStateSelected];
            [labelButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [labelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [segment addSubview:labelButton];
            labelButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [labelButtons addObject:labelButton];
            [segments addObject:segment];
        }
        _segments = segments;
        _labelButtons = labelButtons;
        _bottomSeperator = [UIView new];
        _bottomSeperator.backgroundColor = APPThemeColor;
        _bottomSeperator.layer.masksToBounds = YES;
        _bottomSeperator.layer.cornerRadius = 1.0f;
        [self addSubview:_bottomSeperator];
        _delegate = delegate;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_animatingStart) {
        return;
    }
    CGFloat segmentY = 0.0f;
    CGFloat segmentH = self.bounds.size.height;
    CGFloat segmentW = self.bounds.size.width/_segments.count;
    CGFloat labelX = 10.0f;
    CGFloat labelW = segmentW - 2*labelX;
    CGFloat labelH = labelButtonFont.lineHeight;
    CGFloat labelY = (segmentH-labelH)*0.5;
    for (int i=0; i<_segments.count; i++) {
        UIView *segment = _segments[i];
        CGFloat segmentX = segmentW*i;
        segment.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
        UILabel *labelButton = segment.subviews[0];
        labelButton.frame = CGRectMake(labelX, labelY, labelW, labelH);
    }
    
    CGFloat bottomLineH = 2.5f;
    CGFloat bottomLineW = labelW + 10;
    CGFloat bottomLineX = (segmentW - bottomLineW)*0.5;
    CGFloat bottomLineY = labelY+labelH+5.0f;
    _bottomLinePaddingToSegment = bottomLineX;
    _bottomSeperator.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
}

- (void)segmentTap:(UIGestureRecognizer *)recog
{
    UIView *segment = recog.view;
    if (segment.tag==_lastIndex) {
        return;
    }
    _animatingStart = YES;
    CGFloat bottomSeperatorW = _bottomSeperator.bounds.size.width;
    //计算拉长是的分割线宽度
    CGFloat animateW = segment.bounds.size.width*(abs(segment.tag-_lastIndex)+1)-2*_bottomLinePaddingToSegment;
    if (segment.tag>_lastIndex) {
        _bottomSeperator.anchorLeft.makeWidth(animateW).easeOut.thenAfter(animationTime).anchorRight.makeWidth(bottomSeperatorW).easeIn.animate(animationTime);
    }
    else{
        _bottomSeperator.anchorRight.makeWidth(animateW).easeOut.thenAfter(animationTime).anchorLeft.makeWidth(bottomSeperatorW).easeIn.animate(animationTime);;
    }
    __weak typeof(self) weakSelf = self;
    _bottomSeperator.animationCompletion = JHAnimationCompletion(){
        weakSelf.labelButtons[segment.tag].selected = YES;
        weakSelf.labelButtons[weakSelf.lastIndex].selected = NO;
        weakSelf.lastIndex = segment.tag;
        [weakSelf.delegate ZJSegmentedView:weakSelf selectedAtIndex:segment.tag];
        weakSelf.animatingStart = NO;
    };
}

- (void)selectAtIndex:(NSUInteger)index
{
    [self.delegate ZJSegmentedView:self selectedAtIndex:index];
}

@end
