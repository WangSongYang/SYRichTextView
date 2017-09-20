//
//  SYFrameParserConfig.h
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYFrameParserConfig : NSObject

/** 文本字体 */
@property (nonatomic,strong) UIFont *font;

/** 文本颜色 */
@property (nonatomic,strong) UIColor *color;

/** 文本宽度 */
@property (nonatomic,assign) CGFloat width;

/** 字符间距 */
@property (nonatomic,assign) CGFloat charSpace;

/** 行间距 */
@property (nonatomic,assign) CGFloat lineSpace;

/** 链接字体 */
@property (nonatomic,strong) UIFont *linkFont;

/** 链接颜色 */
@property (nonatomic,strong) UIColor *linkColor;

/** 链接关键字数组 */
@property (nonatomic,strong) NSArray *linkArray;

/** 内容偏移 */
@property (nonatomic,assign) UIEdgeInsets contentOffset;

@end
