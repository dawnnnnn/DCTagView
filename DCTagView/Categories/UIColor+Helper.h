//
//  UIColor+Helper.h
//  DCTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Helper)

+ (UIColor *)dc_colorWithRGBHex:(UInt32)hex alpha:(CGFloat)opacity;

+ (UIColor *)dc_colorWithHexString:(NSString *)hexToConvert;

+ (UIColor *)dc_colorWithHexString:(NSString *)hexToConvert alpha:(CGFloat)opacity;

@end
