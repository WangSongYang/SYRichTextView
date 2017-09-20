//
//  SYFrameParser.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "SYFrameParser.h"
#import "SYFrameParserConfig.h"
#import "SYCoreTextData.h"
#import "SYCoreTextLinkData.h"

@implementation SYFrameParser

+ (SYCoreTextData *)parserNormalString:(NSString *)normalString attConfig:(SYFrameParserConfig *)config {
    // 初始化富文本
    NSAttributedString *attString = [self createAttributeStringWithNormalString:normalString config:config];
    // 创建CTFrameseter实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    // 获取要绘制的区域信息
    // 左右宽度偏移
//    CGFloat lrPading = config.contentOffset.left + config.contentOffset.right;
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, restrictSize, NULL);
    CGFloat textHeight = coreTextSize.height;
    
    // 配置CGFrame信息
    CTFrameRef frameRef = [self createFrameWithFramesetting:framesetter config:config height:textHeight];
    
    // 链接数组
    NSMutableArray *linkArray = [NSMutableArray array];
    for (NSString *linkString in config.linkArray) {
        SYCoreTextLinkData *linkData = [[SYCoreTextLinkData alloc] init];
        linkData.urlString = linkString;
        linkData.range = [normalString rangeOfString:linkString];
        [linkArray addObject:linkData];
    }
    
    // 配置CoreTextData数据
    SYCoreTextData *textData = [[SYCoreTextData alloc] init];
    textData.frameRef = frameRef;
    textData.height = textHeight;
    textData.contentOffset = config.contentOffset;
    textData.linkDataArray = [NSArray arrayWithArray:linkArray.copy];
    
    // 释放内存
    CFRelease(framesetter);
    CFRelease(frameRef);
    
    return textData;
}

#pragma mark --- Private Functions ---

/**
 *  根据CTFramesetterRef、配置信息对象和高度生成对应的CTFrameRef
 *
 *  @param frameSetter CTFramesetterRef
 *  @param config      配置信息对象
 *  @param height      CTFrame高度
 *
 *  @return CTFrameRef
 */
+ (CTFrameRef)createFrameWithFramesetting:(CTFramesetterRef)frameSetter
                                   config:(SYFrameParserConfig *)config
                                   height:(CGFloat)height {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef ctframeRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return ctframeRef;
}

/**
 *  根据配置信息生成对应的富文本
 *
 *  @param config 配置信息
 *
 *  @return NSAttributeString
 **/
+ (NSAttributedString *)createAttributeStringWithNormalString:(NSString *)normalString
                                                       config:(SYFrameParserConfig *)config {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:normalString];
    [attString addAttribute:NSFontAttributeName value:config.font range:NSMakeRange(0, attString.length)];
    [attString addAttribute:NSForegroundColorAttributeName value:config.color range:NSMakeRange(0, attString.length)];
    
    // 添加link
    for (NSString *linkString in config.linkArray) {
        NSRange range = [normalString rangeOfString:linkString];
        
        if (range.length > 0) {
            [attString addAttribute:NSForegroundColorAttributeName value:config.linkColor range:range];
            [attString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
            [attString addAttribute:NSUnderlineColorAttributeName value:config.linkColor range:range];
        }
    }
    // 段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle.copy range:NSMakeRange(0, attString.length)];
    [attString addAttribute:NSKernAttributeName value:@(config.charSpace) range:NSMakeRange(0, attString.length)];
    
    return attString.copy;
}

@end
