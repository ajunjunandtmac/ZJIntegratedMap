//
//  ZJSearchBar.h
//  Tea
//
//  Created by jiale on 16/7/23.
//  Copyright © 2016年 jiale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSearchBar : UIImageView
@property(nonatomic,weak)UISearchBar *searchBar;//暴露在外，方便UISearchDisplayController使用

+ (instancetype)ZJ_searchBarWithBackGroundImage:(UIImage *)backGroundImage delegate:(id<UISearchBarDelegate>)ZJSearchBarDelegate;
+ (instancetype)ZJ_searchBarWithBackGroundImage:(UIImage *)backGroundImage delegate:(id<UISearchBarDelegate>)ZJSearchBarDelegate returnKeyType:(UIReturnKeyType)returnKeyType;
- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color;
- (void)setCancelButtonShow:(BOOL)ifShow;
@end
