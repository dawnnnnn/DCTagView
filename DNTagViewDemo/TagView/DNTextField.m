//
//  DNTextField.m
//  DNTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "DNTextField.h"

@implementation DNTextField

//控制placeHolder 的位置，左右缩 8px
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 0, 5);
}

// 控制文本的位置，左右缩 8px
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 0, 5);
}

@end
