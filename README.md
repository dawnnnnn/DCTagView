## DNTagView

[![Version](https://img.shields.io/cocoapods/v/DNTagView.svg?style=flat-square)](http://cocoadocs.org/docsets/DNTagView)
[![License](https://img.shields.io/cocoapods/l/DNTagView.svg?style=flat-square)](http://cocoadocs.org/docsets/DNTagView)
[![Platform](https://img.shields.io/cocoapods/p/DNTagView.svg?style=flat-square)](http://cocoadocs.org/docsets/DNTagView)

This library is derived from [SKTagView](https://github.com/zsk425/SKTagView), which tries to build a view displaying tags without using UICollectionView and supports Autolayout.

It supports to add tags by UITextField now, and using UIMenuController to delete tag.

### Installation with CocoaPods

```ruby
platform :ios, '8.0'
pod 'DNTagView'
```

##Usage
####Create tag view container

```objc
	self.tagView = ({ DNTagView *view = [DNTagView new];
    view.backgroundColor = [UIColor cyanColor];
    view.padding = UIEdgeInsetsMake(10, 25, 10, 25);
    view.interitemSpacing = 8;
    view.lineSpacing = 10;
    // set delegate
    view.delegate = self;
    view;
    });
```

####Build tag

```
  [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C", @"C", @"PHP"] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
    DNTag *tag = [DNTag tagWithText:text];
    tag.textColor = [UIColor blackColor];
    tag.fontSize = 15;
    tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
    tag.bgColor = [UIColor dn_colorWithHexString:@"0x017E66" alpha:0.08];
    tag.cornerRadius = 3;
    [self.tagView addTag:tag];
  }];
}
```

####Delegate - optional
``` objc
- (void)didInputText:(NSString *)text {
    // you input text;
}

- (void)completeInputText:(NSString *)text {
	// clicked return key 
}

- (void)deleteTag:(NSInteger)index {
    // you have deleted the indexth tag;
}
```

## ScreenShot

![](https://raw.githubusercontent.com/dawnnnnn/DNTagView/master/screenshots/screenshot.gif)

### License

DNTagView is available under the MIT license. See the LICENSE file for more info.
