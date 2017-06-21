//
//  ISearcherDelegate.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/16.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISearchTip.h"
@protocol ITipSearcherDelegate <NSObject>
- (void)onGetTipSearchResult:(NSArray<id<ISearchTip>> *)results;
@end
