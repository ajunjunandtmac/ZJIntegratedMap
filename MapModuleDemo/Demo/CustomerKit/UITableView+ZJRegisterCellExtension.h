//
//  UITableView+ZJRegisterCellExtension.h
//  Tea
//
//  Created by jiale on 16/6/28.
//  Copyright © 2016年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ZJRegisterCellExtension)
- (void)registerCellWithCellClassNameArray:(NSArray<NSString *> *)cellClassNameArray;
@end
