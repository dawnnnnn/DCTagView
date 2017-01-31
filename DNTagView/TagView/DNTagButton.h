//
//  DNTagButton.h
//  DNTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "DNTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNTagButton : UIButton

@property (nonatomic, strong) DNTag *mtag;

+ (instancetype)buttonWithTag: (DNTag *)tag;

@end

NS_ASSUME_NONNULL_END
