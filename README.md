# XHPageControl
一个简洁好用的自定义UIPageControl

实现:
将自定义PageControl类拖到项目中,并导入头文件.

```
//创建pageControl
XHPageControl  *_pageControl = [[XHPageControl alloc] initWithFrame:CGRectMake(0, 300,[UIScreen mainScreen].bounds.size.width, 30)];
//设置点的总个数
_pageControl.numberOfPages = 7;
//设置非选中点的宽度是高度的倍数(设置长条形状)
_pageControl.otherMultiple = 2;
//设置选中点的宽度是高度的倍数(设置长条形状)
_pageControl.currentMultiple = 4;
//设置样式.默认居中显示
_pageControl.type = PageControlLeft;
//非选中点的颜色  
_pageControl.otherColor=[UIColor grayColor];
//选中点的颜色  
_pageControl.currentColor=[UIColor orangeColor];
//代理    
_pageControl.delegate = self;
//标记    
_pageControl.tag = 902;
    
[self.view addSubview:_pageControl];

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
