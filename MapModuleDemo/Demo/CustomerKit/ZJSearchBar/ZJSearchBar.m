//
//  ZJSearchBar.m
//  Tea
//
//  Created by jiale on 16/7/23.
//  Copyright © 2016年 jiale. All rights reserved.
//

#import "ZJSearchBar.h"
@interface ZJSearchBar ()

@property(nonatomic,strong)UIButton *customCancelBtn;
@end

@implementation ZJSearchBar
- (instancetype)initWithBackGroundImage:(UIImage *)backGroundImage delegate:(id<UISearchBarDelegate>)ZJSearchBarDelegate returnKeyType:(UIReturnKeyType)returnKeyType
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [[backGroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 40) resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        [self addSubview:searchBar];
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
        
        //修改取消按钮文字的颜色
        UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class] , nil];
        [item setTitle:@"取消"];
        [item setTitleTextAttributes:attr forState:UIControlStateNormal];
        [searchBar setPositionAdjustment:UIOffsetMake(5, 0) forSearchBarIcon:UISearchBarIconClear];
        //修改searchIcon的图片
        [searchBar setImage:[UIImage imageNamed:@"search_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        self.searchBar = searchBar;
        searchBar.delegate = ZJSearchBarDelegate;
        
        /**
         *  去掉search的clear按钮
         *  把输入键盘的搜索改为完成
         */
        for (UIView *subview in [searchBar.subviews[0] subviews]) {
            if ([subview isKindOfClass:[UITextField class]]) {
                UITextField *tf = (UITextField *)subview;
                tf.returnKeyType = returnKeyType;
                [tf setClearButtonMode:UITextFieldViewModeNever];
            }
        }
        
    }
    return self;
}



- (UIImage *)imageWithColor:(UIColor *)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color
{
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [mStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, placeholder.length)];
    
    UITextField *tf = [_searchBar valueForKey:@"searchField"];
    tf.textColor = color;
    [tf setAttributedPlaceholder:mStr];
}

- (void)setCancelButtonShow:(BOOL)ifShow
{
    [_searchBar setShowsCancelButton:ifShow animated:YES];
    //改变搜索按钮文字
    //改变UISearchBar取消按钮字体
//    for(id subView in [[[_searchBar subviews] lastObject] subviews])
//    {
//        if([subView isKindOfClass:NSClassFromString(@"UINavigationButton")])
//        {
//            UIButton *btn = (UIButton *)subView;
//            btn.height = btn.superview.height - 10;
//            btn.width += 10;
//            btn.centerY = btn.superview.height * 0.5;
//            btn.x = btn.superview.width - btn.width - 5;
//            btn.backgroundColor = [UIColor redColor];
//            [btn setTitle:@"取消" forState:UIControlStateNormal];
//        }
//    }
}

- (void)layoutSubviews
{
    UIImage *clearImg = [self imageWithColor:[UIColor clearColor] andHeight:self.bounds.size.height];
    [_searchBar setBackgroundImage:clearImg];
    [_searchBar setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];
    
    _searchBar.frame = self.bounds;
}

+ (instancetype)ZJ_searchBarWithBackGroundImage:(UIImage *)backGroundImage delegate:(id<UISearchBarDelegate>)ZJSearchBarDelegate
{
    return [[self alloc] initWithBackGroundImage:backGroundImage delegate:ZJSearchBarDelegate returnKeyType:UIReturnKeySearch];
}

+ (instancetype)ZJ_searchBarWithBackGroundImage:(UIImage *)backGroundImage delegate:(id<UISearchBarDelegate>)ZJSearchBarDelegate returnKeyType:(UIReturnKeyType)returnKeyType
{
    return [[self alloc] initWithBackGroundImage:backGroundImage delegate:ZJSearchBarDelegate returnKeyType:returnKeyType];
}

@end
