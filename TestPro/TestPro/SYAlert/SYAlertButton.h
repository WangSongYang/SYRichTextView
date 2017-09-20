//
//  SYAlertButton.h
//  RunTime
//
//  Created by 王颂阳 on 2017/5/22.
//  Copyright © 2017年 WSY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,SYAlertButtonLinePosition) {
    
    SYAlertButtonLinePositionTop        = 0,
    SYAlertButtonLinePositionLeft       = 1 << 0,
    SYAlertButtonLinePositionBottom     = 1 << 1,
    SYAlertButtonLinePositionRight      = 1 << 2,
    SYAlertButtonLinePositionAll        = SYAlertButtonLinePositionTop | SYAlertButtonLinePositionLeft |
                                          SYAlertButtonLinePositionBottom | SYAlertButtonLinePositionRight
};

typedef NS_ENUM(NSInteger, SYAlertButtonCorner){
    
    SYAlertButtonCornerTopleft              = 0,
    SYAlertButtonCornerTopRight             = 1 ,
    SYAlertButtonCornerBottomLeft           = 2,
    SYAlertButtonCornerBottomRight          = 3,
    SYAlertButtonCornerBottomSide           = 4,
    SYAlertButtonCornerTopSide              = 5,
    SYAlertButtonCornerAll                  = 6
};

@interface SYAlertButton : UIButton

/** 按钮线条位置 */
@property (nonatomic,assign) SYAlertButtonLinePosition linePosition;

/** 圆角位置 */
@property (nonatomic,assign) SYAlertButtonCorner corner;

/** 响应回调 */
@property (nonatomic,copy) void (^SYActionBlock)();

/** 按钮相应结束后的回调 */
@property (nonatomic,copy) void (^buttonActionCompleter)(BOOL isFinsh);

@end
