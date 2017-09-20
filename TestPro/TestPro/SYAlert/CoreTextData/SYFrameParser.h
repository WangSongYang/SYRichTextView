//
//  SYFrameParser.h
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYFrameParserConfig;
@class SYCoreTextData;

@interface SYFrameParser : NSObject

/**
 *  根据配置类构造CoreTextData对象
 *
 *  @param normalString 被构造的普通字符串
 *
 *  @param config   富文本参数配置类
 *
 *  @return 构造后的富文本信息类
 **/

+ (SYCoreTextData *)parserNormalString:(NSString *)normalString attConfig:(SYFrameParserConfig *)config;


@end
