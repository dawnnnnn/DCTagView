//
//  UIColor+Helper.m
//  DNTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)

#pragma mark Initialization

+ (UIColor *)dn_colorWithRGBHex:(UInt32)hex alpha:(CGFloat)opacity {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:opacity];
}

+ (UIColor *)dn_colorWithHexString:(NSString *)hexToConvert {
    return [UIColor dn_colorWithHexString:hexToConvert alpha:1.0f];
}

+ (UIColor *)dn_colorWithHexString:(NSString *)hexToConvert alpha:(CGFloat)opacity {
    NSString *colorString = [[[hexToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]] uppercaseString];
    
    if ([colorString hasPrefix:@"0X"]) colorString = [colorString substringFromIndex:2];
    if ([colorString hasPrefix:@"#"])  colorString = [colorString substringFromIndex:1];
    
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    
    return [UIColor dn_colorWithRGBHex:hexNum alpha:opacity];
}

@end
