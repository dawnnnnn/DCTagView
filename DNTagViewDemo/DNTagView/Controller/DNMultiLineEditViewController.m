//
//  DNMultiLineEditViewController.m
//  DNTagView
//
//  Created by dawnnnnn on 2016/10/15.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "DNMultiLineEditViewController.h"

#import "DNTagView.h"

#import "UIColor+Helper.h"
#import <Masonry.h>

@interface DNMultiLineEditViewController ()<DNTagViewDelegate>

@property (nonatomic, strong) DNTagView *tagView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DNMultiLineEditViewController

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
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view).offset(64.);
        }
        make.center.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
}

#pragma mark - DNTagViewDelegate

- (void)didInputText:(NSString *)text {
    // NSLog(@"you input %@", text);
}

- (void)completeInputText:(NSString *)text {
    [self.tagView addTag:[self buildTag:text]];
}

- (void)deleteTag:(NSInteger)index {
    // NSLog(@"you have deleted the indexth tag");
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
