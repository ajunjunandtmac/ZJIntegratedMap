//
//  ZJXMLParse.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "ZJMapConfigXMLParse.h"

static ZJMapConfigXMLParse *parser = nil;
@interface ZJMapConfigXMLParse ()
@property(nonatomic,strong)NSMutableArray<Platform *> *platforms;
@end

@implementation ZJMapConfigXMLParse
+ (instancetype)parser
{
    return [[self alloc] init];
}

- (Platform *)parse
{
    return [self parseWithMapType:MapPlatformTypeFromConfigXML];
}

- (Platform *)parseWithMapType:(MapPlatformType)type
{
    _platforms = [NSMutableArray array];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"MapConfig" withExtension:@"xml"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:fileUrl];
    parser.delegate = self;
    BOOL res = [parser parse];
    Platform *selectedPlatform = nil;
    if (res) {
        if (type==MapPlatformTypeFromConfigXML) {
            for (Platform *platform in _platforms) {
                if ([platform.isOpen boolValue]==true) {
                    selectedPlatform = platform;
                }
            }
        }
        else{
            for (Platform *platform in _platforms) {
                if ([platform.ID integerValue] == type) {
                    selectedPlatform = platform;
                }
            }
        }
    }
    
    return selectedPlatform;
}

#pragma mark - NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"platform"]) {
        Platform *platform = [[Platform alloc] initWithDic:attributeDict];
        [_platforms addObject:platform];
    }
}
@end
