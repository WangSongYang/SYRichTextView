//
//  SYDeclareDisplayView.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/6.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "SYDeclareDisplayView.h"
#import "NSAttributedString+HHHeight.h"
#import "SYCoreTextData.h"

@implementation SYDeclareDisplayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 翻转坐标系
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    CTFrameDraw(self.textData.frameRef, context);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma makr --- Gesture ---

- (void)addTapGestureToView {
    // init gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapGestureAction:(UIGestureRecognizer *)gesture {
    
    
}

#pragma mark --- Setter ---

- (void)setTextData:(SYCoreTextData *)textData {
    if (![_textData isEqual:textData]) {
        _textData = textData;
    }
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(CGRectGetMinX(oldFrame), CGRectGetMinY(oldFrame), CGRectGetWidth(oldFrame), textData.height);
}
@end
