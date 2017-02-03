//
//  DNMultiLineShowViewController.m
//  DNTagView
//
//  Created by dawnnnnn on 2017/2/3.
//  Copyright © 2017年 dawnnnnn. All rights reserved.
//

#import "DNMultiLineShowViewController.h"

#import "DNTagView.h"

#import "UIColor+Helper.h"
#import <Masonry.h>

@interface DNMultiLineShowViewController ()

@property (nonatomic, strong) DNTagView *tagView;
@property (nonatomic, strong) UIButton *addTagButton;
@property (nonatomic, strong) UIButton *insertTagButton;
@property (nonatomic, strong) UIButton *deleteTagButton;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DNMultiLineShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewAddSubviews];
    [self viewLayoutSubviews];
    
    self.dataArray = @[@"python", @"Objective-C", @"Java", @"JavaScript", @"HTML", @"Php", @"Swift"].copy;
    
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tagView addTag:[self buildTag:obj]];
    }];
}

- (void)viewAddSubviews {
    [self.view addSubview:self.tagView];
    [self.view addSubview:self.addTagButton];
    [self.view addSubview:self.insertTagButton];
    [self.view addSubview:self.deleteTagButton];
}

- (void)viewLayoutSubviews {
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.left.and.right.equalTo(self.view);
    }];
    
    [self.addTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView.mas_bottom).with.offset(30);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.insertTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addTagButton.mas_bottom).with.offset(15);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.deleteTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.insertTagButton.mas_bottom).with.offset(15);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - action

- (void)addTagButtonClicked:(UIButton *)button {
    
}

- (void)insertTagButtonClicked:(UIButton *)button {
    
}

- (void)deleteTagButtonClicked:(UIButton *)button {
    
}

#pragma mark - getter

- (DNTagView *)tagView {
    if (_tagView == nil) {
        _tagView = [[DNTagView alloc] initWithState:DNTagViewStateShow];
        _tagView.backgroundColor = [UIColor whiteColor];
        _tagView.padding = UIEdgeInsetsMake(10, 15, 10, 15);
        _tagView.interitemSpacing = 10;
        _tagView.lineSpacing = 10;
    }
    return _tagView;
}

- (UIButton *)addTagButton {
    if (_addTagButton == nil) {
        _addTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addTagButton setTitle:@"add tag" forState:UIControlStateNormal];
        [_addTagButton setBackgroundColor:[UIColor dn_colorWithHexString:@"0x9370DB" alpha:0.4]];
        [_addTagButton addTarget:self action:@selector(addTagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addTagButton;
}

- (UIButton *)insertTagButton {
    if (_insertTagButton == nil) {
        _insertTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_insertTagButton setTitle:@"insert tag at index 0" forState:UIControlStateNormal];
        [_insertTagButton setBackgroundColor:[UIColor dn_colorWithHexString:@"0x9370DB" alpha:0.4]];
        [_insertTagButton addTarget:self action:@selector(insertTagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insertTagButton;
}

- (UIButton *)deleteTagButton {
    if (_deleteTagButton == nil) {
        _deleteTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteTagButton setTitle:@"delete all tag" forState:UIControlStateNormal];
        [_deleteTagButton setBackgroundColor:[UIColor dn_colorWithHexString:@"0x9370DB" alpha:0.4]];
        [_deleteTagButton addTarget:self action:@selector(deleteTagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteTagButton;
}

- (DNTag *)buildTag:(NSString *)tagName {
    DNTag *tag = [DNTag tagWithText:tagName];
    tag.textColor = [UIColor blackColor];
    tag.fontSize = 15;
    tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
    tag.bgColor = [UIColor dn_colorWithHexString:@"0x017E66" alpha:0.08];
    tag.cornerRadius = 3;
    return tag;
}

@end
