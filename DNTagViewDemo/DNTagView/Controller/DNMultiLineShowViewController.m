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

static CGFloat kCommonButtonHeight  = 40.f;
static CGFloat kCommonPaddingLRTB   = 15.f;

@interface DNMultiLineShowViewController ()

@property (nonatomic, strong) DNTagView *tagView;
@property (nonatomic, strong) UIButton *addTagButton;
@property (nonatomic, strong) UIButton *insertTagButton;
@property (nonatomic, strong) UIButton *deleteTagButton;
@property (nonatomic, strong) UILabel *menuEnableTips;
@property (nonatomic, strong) UISwitch *menuEnableSwitch;

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
    [self.view addSubview:self.menuEnableTips];
    [self.view addSubview:self.menuEnableSwitch];
}

- (void)viewLayoutSubviews {
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view).offset(64);
        }
        make.left.and.right.equalTo(self.view);
    }];
    
    [self.addTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView.mas_bottom).with.offset(kCommonPaddingLRTB*2);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(kCommonButtonHeight);
    }];
    
    [self.insertTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addTagButton.mas_bottom).with.offset(kCommonPaddingLRTB);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(kCommonButtonHeight);
    }];
    
    [self.deleteTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.insertTagButton.mas_bottom).with.offset(kCommonPaddingLRTB);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(kCommonButtonHeight);
    }];
    
    [self.menuEnableTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deleteTagButton.mas_bottom).with.offset(kCommonPaddingLRTB);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(kCommonButtonHeight);
    }];
    
    [self.menuEnableSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.menuEnableTips.mas_centerY);
        make.right.equalTo(self.view.mas_right).with.offset(-kCommonPaddingLRTB);
    }];
}

#pragma mark - action

- (void)addTagButtonClicked:(UIButton *)button {
    [self.tagView addTag:[self buildTag:@"new tag"]];
}

- (void)insertTagButtonClicked:(UIButton *)button {
    [self.tagView insertTag:[self buildTag:@"insert tag"] atIndex:0];
}

- (void)deleteTagButtonClicked:(UIButton *)button {
    [self.tagView removeAllTags];
}

- (void)switchAction:(UISwitch *)menuSwitch {
    self.tagView.menuEnable = menuSwitch.isOn;
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

- (UILabel *)menuEnableTips {
    if (_menuEnableTips == nil) {
        _menuEnableTips = [UILabel new];
        _menuEnableTips.text = @"menu enabled";
        _menuEnableTips.backgroundColor = [UIColor dn_colorWithHexString:@"0x9370DB" alpha:0.4];
    }
    return _menuEnableTips;
}

- (UISwitch *)menuEnableSwitch {
    if (_menuEnableSwitch == nil) {
        _menuEnableSwitch = [UISwitch new];
        [_menuEnableSwitch setOn:YES];
        [_menuEnableSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _menuEnableSwitch;
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
