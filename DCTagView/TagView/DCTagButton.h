//
//  DCTagButton.h
//  DCTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "DCTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCTagButton : UIButton

@property (nonatomic, strong) DCTag *mtag;

+ (instancetype)buttonWithTag: (DCTag *)tag;

@end

NS_ASSUME_NONNULL_END
