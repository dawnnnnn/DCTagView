//
//  DCTagView.m
//  DCTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "DCTagView.h"
#import "UIColor+Helper.h"

@interface DCTagView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, assign) BOOL didSetup;

@property (nonatomic, strong) DCTagButton *tmpButton;
@property (nonatomic, assign) NSInteger viewIndex, tagIndex;

@end


@implementation DCTagView

#pragma mark - init
- (instancetype)initWithState:(DCTagViewState)state {
    self = [super init];
    if (self) {
        self.state = state;
        if (self.state == DCTagViewStateEdit) {
            [self addSubview:self.inputText];
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(willInput)];
            [self addGestureRecognizer:tapGes];
        }
    }
    return self;
}


#pragma mark - Lifecycle

- (CGSize)intrinsicContentSize {
    //    if (!self.tags.count) {
    //        return CGSizeMake(375, 45);
    //    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat bottomPadding = self.padding.bottom;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    CGFloat intrinsicHeight = topPadding;
    CGFloat intrinsicWidth = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        NSInteger lineCount = 0;
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    currentX += size.width;
                } else {
                    lineCount ++;
                    currentX = leftPadding + size.width;
                    intrinsicHeight += size.height;
                }
            } else {
                lineCount ++;
                intrinsicHeight += size.height;
                currentX += size.width;
            }
            previousView = view;
            intrinsicWidth = MAX(intrinsicWidth, currentX + rightPadding);
        }
        
        intrinsicHeight += bottomPadding + lineSpacing * (lineCount - 1);
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            intrinsicWidth += size.width;
        }
        intrinsicWidth += itemSpacing * (subviews.count - 1) + rightPadding;
        intrinsicHeight += ((UIView *)subviews.firstObject).intrinsicContentSize.height + bottomPadding;
    }
    
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (void)layoutSubviews {
    if (!self.singleLine) {
        self.preferredMaxLayoutWidth = self.frame.size.width;
    }
    
    [super layoutSubviews];
    
    [self layoutTags];
}

#pragma mark - Custom accessors

- (NSMutableArray *)tags {
    if(!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (void)setPreferredMaxLayoutWidth: (CGFloat)preferredMaxLayoutWidth {
    if (preferredMaxLayoutWidth != _preferredMaxLayoutWidth) {
        _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
        _didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark - Private

- (void)layoutTags {
    //    if (self.didSetup || !self.tags.count) {
    //        return;
    //    }
    if (self.state == DCTagViewStateEdit) {
        [self bringSubviewToFront:self.inputText];
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    view.frame = CGRectMake(currentX, CGRectGetMinY(previousView.frame), size.width, size.height);
                    currentX += size.width;
                } else {
                    CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                    view.frame = CGRectMake(leftPadding, CGRectGetMaxY(previousView.frame) + lineSpacing, width, size.height);
                    currentX = leftPadding + width;
                }
            } else {
                CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                view.frame = CGRectMake(leftPadding, topPadding, width, size.height);
                currentX += width;
            }
            
            previousView = view;
        }
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            view.frame = CGRectMake(currentX, topPadding, size.width, size.height);
            currentX += size.width;
            currentX += itemSpacing;
            
            previousView = view;
        }
    }
    
    self.didSetup = YES;
}

#pragma mark - IBActions

- (void)onTag:(DCTagButton *)btn {
    //    if (self.didTapTagAtIndex) {
    //        self.didTapTagAtIndex([self.subviews indexOfObject: btn]);
    //    }
    //    [self removeTagAtIndex:[self.subviews indexOfObject:btn]];
    
    self.tmpButton.selected = NO;
    [self.tmpButton setBackgroundColor:[UIColor dc_colorWithHexString:@"0x017E66" alpha:0.08]];
    self.tmpButton = btn;
    self.viewIndex = [self.subviews indexOfObject:btn];
    self.tagIndex = [self.tags indexOfObject:btn.mtag.text];
    
    CGRect buttonFrame = btn.frame;
    [self.inputText resignFirstResponder];
    [self becomeFirstResponder];
    UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除"action:@selector(menuDelete:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    menu.arrowDirection = UIMenuControllerArrowDefault;
    [menu setMenuItems:[NSArray arrayWithObject:deleteItem]];
    [menu setTargetRect:buttonFrame inView:self];
    
    NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot become first responder", self);
    [menu setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)menuDelete:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteTag:)]) {
        [self.delegate deleteTag:self.tagIndex];
    }
    [self removeTagAtIndex:self.viewIndex];
}


#pragma mark - Public

- (void)addTag: (DCTag *)tag {
    NSParameterAssert(tag);
    DCTagButton *btn = [DCTagButton buttonWithTag: tag];
    if (self.state == DCTagViewStateEdit) {
        [btn addTarget: self action: @selector(onTag:) forControlEvents: UIControlEventTouchUpInside];
        self.inputText.text = @"";
    }
    [self addSubview: btn];
    [self.tags addObject: tag.text];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)insertTag:(DCTag *)tag atIndex:(NSUInteger)index {
    NSParameterAssert(tag);
    if (index + 1 > self.tags.count) {
        [self addTag: tag];
    } else {
        DCTagButton *btn = [DCTagButton buttonWithTag: tag];
        if (self.state == DCTagViewStateEdit) {
            [btn addTarget: self action: @selector(onTag:) forControlEvents: UIControlEventTouchUpInside];
        }
        [self insertSubview: btn atIndex: index];
        [self.tags insertObject: tag.text atIndex: index];
        
        self.didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)removeTag:(DCTag *)tag {
    NSParameterAssert(tag);
    NSUInteger index = [self.tags indexOfObject: tag.text];
    if (NSNotFound == index) {
        return;
    }
    
    [self.tags removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeTagAtIndex: (NSUInteger)index {
    if (index + 1 > self.tags.count) {
        return;
    }
    
    [self.tags removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeAllTags {
    [self.tags removeAllObjects];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)makeButtonHighlight {
    self.tmpButton.selected = YES;
    [self.tmpButton setBackgroundColor:[UIColor dc_colorWithHexString:@"#009A61"]];
}

- (void)makeButtonNormal {
    self.tmpButton.selected = NO;
    [self.tmpButton setBackgroundColor:[UIColor dc_colorWithHexString:@"#017E66" alpha:0.08]];
}

- (void)willInput {
    [self.inputText becomeFirstResponder];
}

#pragma mark - textfiel delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text) {
        DCTag *tag = [DCTag tagWithText:textField.text];
        tag.textColor = [UIColor dc_colorWithHexString:@"#009A61"];
        tag.fontSize = 15;
        tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
        tag.bgColor = [UIColor dc_colorWithHexString:@"#017E66" alpha:0.08];
        tag.cornerRadius = 3;
        [self addTag:tag];
        self.inputText.text = @"";
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}

- (void)textFieldDidChanged:(UITextField*)textField{
    self.didSetup = NO;
    [self layoutTags];
    [self invalidateIntrinsicContentSize];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didInputText:)]) {
        [self.delegate didInputText:textField.text];
    }
}


#pragma mark - getter
- (DCTextField *)inputText {
    if (!_inputText) {
        DCTextField *textField = [DCTextField new];
        textField.textColor = [UIColor blackColor];
        textField.font = [UIFont systemFontOfSize:15];
        textField.placeholder = @"输入标签";
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _inputText = textField;
    }
    return _inputText;
}

@end
