//
//  Platform.h
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Platform : NSObject
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *appKey;
@property(nonatomic,copy)NSString *factoryName;
@property(nonatomic,copy)NSString *isOpen;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
