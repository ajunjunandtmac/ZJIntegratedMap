//
//  UITableView+ZJRegisterCellExtension.m
//  Tea
//
//  Created by jiale on 16/6/28.
//  Copyright © 2016年 jiale. All rights reserved.
//

#import "UITableView+ZJRegisterCellExtension.h"

@implementation UITableView (ZJRegisterCellExtension)
- (void)registerCellWithCellClassNameArray:(NSArray<NSString *> *)cellClassNameArray
{
    for (NSString *cellClassName in cellClassNameArray) {
        id xibPath = [[NSBundle bundleForClass:NSClassFromString(cellClassName)] pathForResource:cellClassName ofType:@"nib"];
        if (xibPath == nil) {
            [self registerClass:NSClassFromString(cellClassName) forCellReuseIdentifier:cellClassName];
        }
        else{
            [self registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellReuseIdentifier:cellClassName];
        }
    }
}
@end
