//
//  UIViewController+Extension.m
//  showPhoto
//
//  Created by jiale on 16/2/2.
//  Copyright © 2016年 金炜皓. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>
#import <objc/message.h>
@implementation UIViewController (Extension)
- (void)zj_dealloc
{
    NSLog(@"%@---->dealloced",NSStringFromClass([self class]));
    [self zj_dealloc];
}

- (void)zj_viewDidLoad
{
    /**
     * 执行[super viewDidLoad]时,又会调用一次此方法
     * 当执行到最后一段代码时，不会调用具体的控制器的viewDidLoad方法
     * 而是还是会根据super标识，调用UIViewController(父类)的viewDidLoad方法
     * 父类的方法中不会有[super viewDidLoad]的代码
     * 所以不会再次执行zj_viewDidLoad，故而不会造成死循环
     */
    //MYLog(@"%s",__func__);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self zj_viewDidLoad];
}

+ (void)load
{
    [super load];
    Method system_dealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method my_dealloc = class_getInstanceMethod([self class], @selector(zj_dealloc));
    method_exchangeImplementations(system_dealloc, my_dealloc);
    
    Method system_viewDidLoad = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method my_viewDidLoad = class_getInstanceMethod([self class], @selector(zj_viewDidLoad));
    method_exchangeImplementations(system_viewDidLoad, my_viewDidLoad);
}


- (void)createAlbumInPhoneAlbum:(NSString *)customAlbumName Image:(UIImage *)image successBlock:(void (^)(void))successBlock
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups=[[NSMutableArray alloc]init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group)
        {
            [groups addObject:group];
        }
        
        else
        {
            BOOL haveHDRGroup = NO;
            
            for (ALAssetsGroup *gp in groups)
            {
                NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:customAlbumName])
                {
                    haveHDRGroup = YES;
                }
            }
            
            if (!haveHDRGroup)
            {
                //do add a group named "XXXX"
                [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName
                                               resultBlock:^(ALAssetsGroup *group)
                 {
                     [groups addObject:group];
                     
                 }
                                              failureBlock:nil];
                haveHDRGroup = YES;
            }
        }
        
    };
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
    
    [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(image) customAlbumName:customAlbumName completionBlock:^
     {
         successBlock();
         
     }
                     failureBlock:^(NSError *error)
     {
         //处理添加失败的方法显示alert让它回到主线程执行，不然那个框框死活不肯弹出来
         dispatch_async(dispatch_get_main_queue(), ^{
             
             //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
             if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location!=NSNotFound){
                 
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                 
                 [alert show];
                 
             }
         });
     }];
}

#pragma mark - 保存相片到自定义相簿
- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock
{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    
    __weak ALAssetsLibrary *weakAssetsLibrary = assetsLibrary;
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [weakAssetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock();
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(weakAssetsLibrary, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(weakAssetsLibrary, assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}



@end
