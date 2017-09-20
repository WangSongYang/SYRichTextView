//
//  NSAttributedString+HHHeight.h
//  huaerweike
//
//  Created by 秦山 on 15/11/10.
//  Copyright © 2015年 dfhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (HHHeight)

- (CGSize)sizeThatFitswithConstraints:(CGSize)size
                limitedToNumberOfLines:(NSUInteger)numberOfLines;

- (CGFloat)heightWithconstrainedToWidth:(CGFloat)width;

@end
