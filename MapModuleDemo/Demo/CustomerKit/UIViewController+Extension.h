//
//  UIViewController+Extension.h
//  showPhoto
//
//  Created by jiale on 16/2/2.
//  Copyright © 2016年 金炜皓. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIActivityIndicatorView;
@interface UIViewController (Extension)
- (void)createAlbumInPhoneAlbum:(NSString *)customAlbumName Image:(UIImage *)image successBlock:(void (^)(void))successBlock;
@end
