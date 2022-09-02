# XHPageControl
一个简洁好用的自定义UIPageControl

Swift版本的请参考https://github.com/zxhkit/JJPageControl
Swift简书:[Swift自定义PageControl](https://www.jianshu.com/p/057bbce5aa22)


实现:
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
