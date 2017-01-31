//
//  DNTagView.h
//  DNTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNTag.h"
#import "DNTagButton.h"
#import "DNTextField.h"

typedef NS_ENUM(NSInteger, DNTagViewState) {
    DNTagViewStateShow    = 0,
    DNTagViewStateEdit    = 1
};

NS_ASSUME_NONNULL_BEGIN

@protocol DNTagViewDelegate <NSObject>

- (void)didInputText:(NSString *)text;
- (void)deleteTag:(NSInteger)index;

@end

@interface DNTagView : UIView

@property (nonatomic, assign) DNTagViewState state;
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) CGFloat preferredMaxLayoutWidth;
@property (nonatomic, assign) BOOL singleLine;

//@property (copy, nonatomic, nullable) void (^didTapTagAtIndex)(NSUInteger index);
@property (nonatomic, strong, readonly) NSMutableArray *tags;

@property (nonatomic, weak) id<DNTagViewDelegate> delegate;

@property (nonatomic, strong) DNTextField *inputText;

- (instancetype)initWithState:(DNTagViewState)state;

- (void)addTag:(DNTag *)tag;
- (void)insertTag:(DNTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag:(DNTag *)tag;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeAllTags;

- (void)makeButtonHighlight;
- (void)makeButtonNormal;

@end

NS_ASSUME_NONNULL_END
