//
//  DCTagView.h
//  DCTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCTag.h"
#import "DCTagButton.h"
#import "DCTextField.h"

typedef NS_ENUM(NSInteger, DCTagViewState) {
    DCTagViewStateShow    = 0,
    DCTagViewStateEdit    = 1
};

NS_ASSUME_NONNULL_BEGIN

@protocol SFTagViewDelegate <NSObject>

- (void)didInputText:(NSString *)text;
- (void)deleteTag:(NSInteger)index;

@end

@interface DCTagView : UIView

@property (nonatomic, assign) DCTagViewState state;
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) CGFloat preferredMaxLayoutWidth;
@property (nonatomic, assign) BOOL singleLine;

//@property (copy, nonatomic, nullable) void (^didTapTagAtIndex)(NSUInteger index);
@property (nonatomic, strong, readonly) NSMutableArray *tags;

@property (nonatomic, weak) id<SFTagViewDelegate> delegate;

@property (nonatomic, strong) DCTextField *inputText;

- (instancetype)initWithState:(DCTagViewState)state;

- (void)addTag:(DCTag *)tag;
- (void)insertTag:(DCTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag:(DCTag *)tag;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeAllTags;

- (void)makeButtonHighlight;
- (void)makeButtonNormal;

@end

NS_ASSUME_NONNULL_END
