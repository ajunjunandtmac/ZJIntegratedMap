//
//  IPOISearcherDelegate.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPOISearchResult.h"
@protocol IPOISearcherDelegate <NSObject>
- (void)onGetPOISearchResults:(NSArray<id<IPOISearchResult>> *)results;
@end
