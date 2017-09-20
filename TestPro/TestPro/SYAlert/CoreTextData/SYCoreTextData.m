//
//  SYCoreTextData.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/9/8.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "SYCoreTextData.h"

@implementation SYCoreTextData

- (void)setFrameRef:(CTFrameRef)frameRef {
    if (_frameRef != nil && _frameRef != frameRef) {
        CFRelease(_frameRef);
    }
    CFRetain(frameRef);
    _frameRef = frameRef;
}

@end
