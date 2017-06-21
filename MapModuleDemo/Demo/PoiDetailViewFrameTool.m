//
//  PoiDetailViewFrameTool.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/18.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "PoiDetailViewFrameTool.h"
#import "NSString+AutoCountLabelSize.h"
static CGFloat const paddingY = 12;
@implementation PoiDetailViewFrameTool
- (void)configureFrameWithPoiDetailInfo:(id<IPoiDetailSearchResult>)result viewWidth:(CGFloat)viewWidth
{
    _poiDetailInfo = result;
    CGFloat goThereButtonWH = 60;
    CGFloat goThereButtonY = 0;
    CGFloat goThereButtonX = viewWidth - 20 - goThereButtonWH;
    self.goThereButtonRect = CGRectMake(goThereButtonX, goThereButtonY, goThereButtonWH, goThereButtonWH);
    
    CGFloat arrowDownWH = 25;
    CGFloat arrowDownY = 0;
    CGFloat arrowDownX = (viewWidth-arrowDownWH)*0.5;
    self.arrowDownButtonRect = CGRectMake(arrowDownX, arrowDownY, arrowDownWH, arrowDownWH);
    
    CGFloat titleLabelX = 12;
    CGFloat titleLabelY = 20;
    CGSize titleLabelS = [result.getName sizeWithFontForSingleRow:titleLabelFont];
    self.titleLabelRect = CGRectMake(titleLabelX, titleLabelY, titleLabelS.width, titleLabelS.height);
    
    CGFloat addressLabelX = titleLabelX;
    CGFloat addressLabelY = CGRectGetMaxY(self.titleLabelRect) + paddingY;
    CGSize addressLabelS = [result.address sizeWithFontforMultiRows:addressLabelFont rowMaxWidth:viewWidth-addressLabelX*2];
    self.addressLabelRect = CGRectMake(addressLabelX, addressLabelY, addressLabelS.width, addressLabelS.height);
    
    CGFloat distanceShowButtonX = addressLabelX;
    CGFloat distanceShowButtonY = CGRectGetMaxY(self.addressLabelRect)+paddingY;
    CGFloat distanceShowButtonW = viewWidth;
    CGFloat distanceShowButtonH = [@"千米" sizeWithFontForSingleRow:distanceShowLabelFont].height;
    self.distanceShowButtonRect = CGRectMake(distanceShowButtonX, distanceShowButtonY, distanceShowButtonW,distanceShowButtonH);
    
    CGFloat infoBackH = CGRectGetMaxY(self.distanceShowButtonRect) + paddingY;
    CGFloat infoBackX = 0;
    CGFloat infoBackW = viewWidth;
    CGFloat infoBackY = CGRectGetMidY(self.goThereButtonRect);
    self.infoBackViewRect = CGRectMake(infoBackX, infoBackY, infoBackW, infoBackH);
    
    self.viewHeight = CGRectGetMaxY(self.infoBackViewRect);
    self.animateVerticalMoveDistance = self.viewHeight-goThereButtonWH*0.5;
    
}
@end
