//
//  IPOIDetailSearcherDelegate.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPoiDetailSearchResult.h"
@protocol IPOIDetailSearcherDelegate <NSObject>
- (void)onGetPOIDetailSearchResult:(id<IPoiDetailSearchResult>)result;
@end
