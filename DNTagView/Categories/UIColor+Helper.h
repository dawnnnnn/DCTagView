//
//  UIColor+Helper.h
//  DNTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Helper)

+ (UIColor *)dn_colorWithRGBHex:(UInt32)hex alpha:(CGFloat)opacity;

+ (UIColor *)dn_colorWithHexString:(NSString *)hexToConvert;

+ (UIColor *)dn_colorWithHexString:(NSString *)hexToConvert alpha:(CGFloat)opacity;

@end
