//
//  SYFrameParserConfig.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "SYFrameParserConfig.h"

#define kDefaultTextFont    [UIFont systemFontOfSize:14]
#define kDefaultTextColor   [UIColor blackColor]
#define kDefaultLinkFont    [UIFont systemFontOfSize:14]
#define kDefaultLinkColor   [UIColor blueColor]

static CGFloat const defaultWidth = 320;
static CGFloat const defaultCharSpace = 1;
static CGFloat const defaultLineSpace = 5;


@implementation SYFrameParserConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = kDefaultTextFont;
        self.color = kDefaultTextColor;
        self.width = defaultWidth;
        self.charSpace = defaultCharSpace;
        self.lineSpace = defaultLineSpace;
        self.linkFont = kDefaultLinkFont;
        self.linkColor = kDefaultLinkColor;
        self.linkArray = [NSArray array];
        self.contentOffset = UIEdgeInsetsZero;
    }
    return self;
}
@end
