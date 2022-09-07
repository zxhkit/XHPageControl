# XHPageControl

[![CI Status](https://img.shields.io/travis/oauth2/XHPageControl.svg?style=flat)](https://travis-ci.org/oauth2/XHPageControl)
[![Version](https://img.shields.io/cocoapods/v/XHPageControl.svg?style=flat)](https://cocoapods.org/pods/XHPageControl)
[![License](https://img.shields.io/cocoapods/l/XHPageControl.svg?style=flat)](https://cocoapods.org/pods/XHPageControl)
[![Platform](https://img.shields.io/cocoapods/p/XHPageControl.svg?style=flat)](https://cocoapods.org/pods/XHPageControl)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Summary

The latest version: 0.1.0

A concise and user-friendly custom UIPageControl

Please refer to the Swift version:[Swift版本:JJPageControl](https://github.com/zxhkit/JJPageControl)

## Requirements
```
  >= iOS 10.0
```

## Installation

XHPageControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XHPageControl'
```

## Use

将自定义PageControl类拖到项目中,并导入头文件.
```
//创建pageControl
XHPageControl  *pageControl = [[XHPageControl alloc] initWithFrame:CGRectMake(0, 300,[UIScreen mainScreen].bounds.size.width, 30)];
//设置点的总个数
pageControl.numberOfPages = 7;
//设置非选中点的大小（宽度和高度）
pageControl.otherPointSize = CGSizeMake(12, 6);
//设置选中点的大小（宽度和高度）
pageControl.currentPointSize = CGSizeMake(24, 6);
//设置圆角大小
pageControl.pointCornerRadius = 3;
//设置两点之间的间隙
pageControl.controlSpacing = 3;
//左右间宽,只有在居左居右显示的时候才有用
pageControl.leftAndRightSpacing = 10;
//设置样式.默认居中显示
pageControl.pageAliment = PageControlMiddle;
//非选中点的颜色  
pageControl.otherColor=[UIColor grayColor];
//选中点的颜色  
pageControl.currentColor=[UIColor orangeColor];
//当只有一个点的时候是否隐藏,默认隐藏
pageControl. isHidesForSinglePage = YES;
//是否可以点击,默认不可以点击
pageControl .isCanClickPoint = YES;
//代理    
pageControl.delegate = self;
//标记    
pageControl.tag = 902;
    
[self.view addSubview:pageControl];

```
代理实现:

```
#pragma mark - 代理
- (void)xh_PageControlClick:(XHPageControl*)pageControl index:(NSInteger)clickIndex{

    NSLog(@"%ld",clickIndex);
    if(pageControl.tag == 902){
        CGPoint position = CGPointMake([UIScreen mainScreen].bounds.size.width * clickIndex, 0);
        [_scrollView2 setContentOffset:position animated:YES];
    }
}


```

## Author

zhouxuanhe, 820331062@qq.com

## License

XHPageControl is available under the MIT license. See the LICENSE file for more info.
