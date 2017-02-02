//
//  DNViewController.m
//  DNTagView
//
//  Created by dawnnnnn on 2016/10/15.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "DNViewController.h"

#import "DNTagView.h"

#import "UIColor+Helper.h"
#import <Masonry.h>

@interface DNViewController ()<DNTagViewDelegate>

@property (nonatomic, strong) DNTagView *tagView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewAddSubviews];
    
    self.dataArray = @[@"python", @"Objective-C", @"Java", @"JavaScript", @"HTML", @"Php", @"Swift"].copy;
    
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tagView addTag:[self buildTag:obj]];
    }];
}

- (void)viewAddSubviews {
    
    [self.view addSubview:self.tagView];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.trailing.equalTo(self.view);
    }];
}






#pragma mark - getter
- (DNTagView *)tagView {
    if (_tagView == nil) {
        _tagView = [[DNTagView alloc]initWithState:DNTagViewStateEdit];
        _tagView.backgroundColor = [UIColor whiteColor];
        _tagView.padding = UIEdgeInsetsMake(10, 15, 10, 15);
        _tagView.interitemSpacing = 10;
        _tagView.lineSpacing = 10;
        _tagView.delegate = self;
//        [_tagView.inputText becomeFirstResponder];
    }
    return _tagView;
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
