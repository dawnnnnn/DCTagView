//
//  DNTag.h
//  DNTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNTag : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *highlightedBgColor;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) UIImage *bgImg;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
///like padding in css
@property (nonatomic, assign) UIEdgeInsets padding;
///if no font is specified, system font with fontSize is used
@property (nonatomic, assign) CGFloat fontSize;
///default:YES
@property (nonatomic, assign) BOOL enable;

- (nonnull instancetype)initWithText: (nonnull NSString *)text;
+ (nonnull instancetype)tagWithText: (nonnull NSString *)text;

@end

NS_ASSUME_NONNULL_END
