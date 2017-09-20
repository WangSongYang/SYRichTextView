//
//  SYCoreTextLinkData.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "SYCoreTextLinkData.h"
#import "SYCoreTextData.h"
#import <CoreText/CoreText.h>

@implementation SYCoreTextLinkData

+ (SYCoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(SYCoreTextData *)data {
    
    SYCoreTextLinkData *linkData = nil;
    
    CTFrameRef frameRef = data.frameRef;
    CFArrayRef lines = CTFrameGetLines(frameRef);
    if (lines == nil) {
        return nil;
    }
    
    CFIndex linesCount = CFArrayGetCount(lines);
    CGPoint linesOrigins[linesCount];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), linesOrigins);
    
    // 由于CoreText和UIKit坐标系不同，所以要做个对应转换
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1, -1);
    
    for (int i = 0; i < linesCount; i++) {
        CGPoint linePoint = linesOrigins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        // 获取当前行的rect信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        // 将CoreText坐标转换为UIKit坐标
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        // 判断点是否在Rect中
        if (CGRectContainsPoint(flippedRect, point)) {
            // 获取点在line行中的位置
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            // 获取点钟字符在line中的位置（在属性文字中是第几个字）
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            // 判断此字符是否在链接属性文字中
            linkData = [self linkAtIndex:idx linkArray:data.linkDataArray];
            break;
        }
    }
    return linkData;
}

+ (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {
    // 配置line行的位置信息
    CGFloat ascent = 0;
    CGFloat descent = 0;
    CGFloat leading = 0;
    
    // 在获取line行的宽度信息的同时得到其他信息
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y, width, height);
}

+ (SYCoreTextLinkData *)linkAtIndex:(CFIndex)i linkArray:(NSArray *)linkArray {
    
    SYCoreTextLinkData *linkData = nil;
    for (SYCoreTextLinkData *data in linkArray) {
        if (NSLocationInRange(i, data.range)) {
            linkData = data;
            break;
        }
    }
    return linkData;
}
@end
