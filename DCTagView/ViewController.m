//
//  ViewController.m
//  DCTagView
//
//  Created by dawnnnnn on 16/9/1.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "ViewController.h"

#import "DCTagView.h"

#import "UIColor+Helper.h"
#import <Masonry.h>

@interface ViewController ()<DCTagViewDelegate>

@property (nonatomic, strong) DCTagView *tagView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    
    self.dataArray = @[@"python", @"Objective-C", @"Java", @"JavaScript", @"HTML", @"Php", @"Swift"].copy;
    
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tagView addTag:[self buildTag:obj]];
    }];
}

- (void)initialize {
    [self.view addSubview:self.tagView];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
}






#pragma mark - getter
- (DCTagView *)tagView {
    if (!_tagView) {
        DCTagView *view = [[DCTagView alloc]initWithState:DCTagViewStateEdit];
        view.backgroundColor = [UIColor whiteColor];
        view.padding = UIEdgeInsetsMake(10, 15, 10, 15);
        view.interitemSpacing = 10;
        view.lineSpacing = 10;
        view.delegate = self;
        [view.inputText becomeFirstResponder];
        _tagView = view;
    }
    return _tagView;
}

- (DCTag *)buildTag:(NSString *)tagName {
    DCTag *tag = [DCTag tagWithText:tagName];
    tag.textColor = [UIColor blackColor];
    tag.fontSize = 15;
    tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
    tag.bgColor = [UIColor dc_colorWithHexString:@"0x017E66" alpha:0.08];
    tag.cornerRadius = 3;
    return tag;
}


@end
