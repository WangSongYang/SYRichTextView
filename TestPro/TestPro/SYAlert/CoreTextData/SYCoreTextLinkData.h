//
//  SYCoreTextLinkData.h
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SYCoreTextData;

@interface SYCoreTextLinkData : NSObject

/**  NSString类型url链接地址 */
@property (nonatomic, strong) NSString *urlString;

/**  文字在属性文字中的范围 */
@property (nonatomic, assign) NSRange range;

/**
 *  若点击位置有链接返回链接对象否则返回nil
 *
 *  @param view  点击的视图
 *  @param point 点击位置
 *  @param data  存放富文本的数据
 *
 *  @return 返回链接对象
 */
+ (SYCoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(SYCoreTextData *)data;

@end
