//
//  SYOpenCountProtocolView.h
//  OriginFX
//
//  Created by 王颂阳 on 2017/6/6.
//  Copyright © 2017年 tianyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYOpenCountProtocolViewDelegate <NSObject>

- (void)userClickedLinkUrlString:(NSString *)urlString;

- (void)userSelectProtocolAtIndex:(NSInteger)index;

@end

@interface SYOpenCountProtocolView : UIView

/** SelectCount */
@property (nonatomic,assign,readonly) BOOL isAllSelected;

/** delegate */
@property (nonatomic,weak) id<SYOpenCountProtocolViewDelegate> delegate;

@end
