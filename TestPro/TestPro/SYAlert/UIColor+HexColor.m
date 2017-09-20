//
//  UIColor+HexColor.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/8/15.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    if (cString.length < 6) {
        return [UIColor whiteColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length != 6) {
        return [UIColor whiteColor];
    }
    
    // 从六位数中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    // R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1];
}

@end
