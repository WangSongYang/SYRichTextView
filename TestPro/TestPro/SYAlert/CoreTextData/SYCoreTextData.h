//
//  SYCoreTextData.h
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface SYCoreTextData : NSObject

/** CTFrame */
@property (nonatomic,assign) CTFrameRef frameRef;

/** 内容高度 */
@property (nonatomic,assign) CGFloat height;

/** 链接 */
@property (nonatomic,strong) NSArray *linkDataArray;

#pragma makr --- 暂不添加处理 ---
/** 内容偏移 */
@property (nonatomic,assign) UIEdgeInsets contentOffset;

@end
