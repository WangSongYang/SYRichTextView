//
//  SYAlertButton.m
//  RunTime
//
//  Created by 王颂阳 on 2017/5/22.
//  Copyright © 2017年 WSY. All rights reserved.
//

#import "SYAlertButton.h"

@interface SYAlertButton ()



@end

@implementation SYAlertButton

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"bdbdbd"].CGColor);
    
    switch (self.linePosition) {
        case SYAlertButtonLinePositionTop:
            
            CGContextStrokeRect(context, CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.3));
            
            break;
        case SYAlertButtonLinePositionRight | SYAlertButtonLinePositionTop:
        {
            CGContextStrokeRect(context, CGRectMake(CGRectGetWidth(self.frame) - 0.3, 0, 0.3, CGRectGetHeight(self.frame)));
            
            CGContextStrokeRect(context, CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.3));
        }
            break;
        default:
            break;
    }

}

- (void)makeMaskCornerWithSide:(SYAlertButtonCorner)cornerSide {
    
    switch (cornerSide) {
        case SYAlertButtonCornerBottomLeft:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(10.0f, 10.0f)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = path.CGPath;
            self.layer.mask = maskLayer;
        }
            break;
            
        case SYAlertButtonCornerBottomRight:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = path.CGPath;
            self.layer.mask = maskLayer;
        }
            break;
        case SYAlertButtonCornerBottomSide:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight )cornerRadii:CGSizeMake(10.0f, 10.0f)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = path.CGPath;
            self.layer.mask = maskLayer;
        }
            break;
            
        case SYAlertButtonCornerAll:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10.0f, 10.0f)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = path.CGPath;
            self.layer.mask = maskLayer;
        }
        default:
            break;
    }
}


#pragma mark ---- Setter ---

- (void)setLinePosition:(SYAlertButtonLinePosition)linePosition {
    
    _linePosition = linePosition;
    
    [self drawRect:self.bounds];
}

- (void)setCorner:(SYAlertButtonCorner)corner {
    
    _corner = corner;
    
    [self makeMaskCornerWithSide:corner];
}
@end
