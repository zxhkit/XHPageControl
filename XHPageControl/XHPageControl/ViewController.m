//
//  ViewController.m
//  XHPageControl
//
//  Created by xuanhe on 2022/9/2.
//  github:https://github.com/zxhkit/XHPageControl
//  简书:https://www.jianshu.com/p/aae83cfaeeb4
//

#import "ViewController.h"
#import "XHPageControl.h"

@interface ViewController ()<UIScrollViewDelegate,XHPageControlDelegate>

@property(nonatomic,strong) UIScrollView *scrollView1;
@property(nonatomic,strong) UIScrollView *scrollView2;
@property(nonatomic,strong) UIScrollView *scrollView3;
@property(nonatomic,strong) UIScrollView *scrollView4;

@property(nonatomic,strong) XHPageControl *pageControl1;
@property(nonatomic,strong) XHPageControl *pageControl2;
@property(nonatomic,strong) XHPageControl *pageControl3;
@property(nonatomic,strong) XHPageControl *pageControl4;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 100)];
    _scrollView1.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*7, 100);
    _scrollView1.delegate = self;
    _scrollView1.pagingEnabled = YES;
    _scrollView1.tag = 1001;
    for (int i = 1; i <=7; i++) {
        [self.scrollView1 addSubview:[self createImgView:i]];
    }
    [self.view addSubview:_scrollView1];
    
    
    _scrollView2 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 100)];
    _scrollView2.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*7, 100);
    _scrollView2.delegate = self;
    _scrollView2.pagingEnabled = YES;
    _scrollView2.tag = 1002;
    for (int i = 1; i <=7; i++) {
        [self.scrollView2 addSubview:[self createImgView:i]];
    }
    [self.view addSubview:_scrollView2];
    
    _scrollView3 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 340, [UIScreen mainScreen].bounds.size.width, 100)];
    _scrollView3.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*7, 100);
    _scrollView3.delegate = self;
    _scrollView3.pagingEnabled = YES;
    _scrollView3.tag = 1003;
    for (int i = 1; i <=7; i++) {
        [self.scrollView3 addSubview:[self createImgView:i]];
    }
    [self.view addSubview:_scrollView3];
    
    
    _scrollView4 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 480, [UIScreen mainScreen].bounds.size.width, 100)];
    _scrollView4.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*7, 100);
    _scrollView4.delegate = self;
    _scrollView4.pagingEnabled = YES;
    _scrollView4.tag = 1004;
    for (int i = 1; i <=7; i++) {
        [self.scrollView4 addSubview:[self createImgView:i]];
    }
    [self.view addSubview:_scrollView4];
    
    _pageControl1 = [[XHPageControl alloc] init];
    _pageControl1.frame=CGRectMake(0, 160,[UIScreen mainScreen].bounds.size.width, 30);
    _pageControl1.numberOfPages = 7;
    _pageControl1.delegate = self;
    _pageControl1.tag = 901;
    [self.view addSubview:_pageControl1];
    
    
    _pageControl2 = [[XHPageControl alloc] initWithFrame:CGRectMake(0, 300,[UIScreen mainScreen].bounds.size.width, 30)];
    _pageControl2.numberOfPages = 7;
    _pageControl2.otherPointSize = CGSizeMake(12, 6);
    _pageControl2.currentPointSize = CGSizeMake(24, 6);
    _pageControl2.pageAliment = PageControlLeft;
    _pageControl2.otherColor = [UIColor colorWithRed:14/255.0 green:65/255.0 blue:189/255.0 alpha:1];
    _pageControl2.currentColor = [UIColor colorWithRed:98/255.0 green:152/255.0 blue:19/255.0 alpha:1];
    _pageControl2.delegate = self;
    _pageControl2.tag = 902;
    _pageControl2.layer.borderWidth = 1;
    [self.view addSubview:_pageControl2];
    
    
    
    _pageControl3 = [[XHPageControl alloc] initWithFrame:CGRectMake(0, 440,[UIScreen mainScreen].bounds.size.width, 30)];
    _pageControl3.numberOfPages = 7;
    _pageControl3.otherPointSize = CGSizeMake(18, 18);
    _pageControl3.currentPointSize = CGSizeMake(18, 18);
    _pageControl3.controlSpacing = 15;
    _pageControl3.currentBkImage = [UIImage imageNamed:@"image1"];
    _pageControl3.otherBkImage = [UIImage imageNamed:@"image2"];
    _pageControl3.delegate = self;
    _pageControl3.tag = 903;
    [self.view addSubview:_pageControl3];
    
    _pageControl4 = [[XHPageControl alloc] initWithFrame:CGRectMake(0, 580,[UIScreen mainScreen].bounds.size.width, 30)];
    _pageControl4.numberOfPages = 7;
    _pageControl4.otherPointSize = CGSizeMake(6, 6);
    _pageControl4.currentPointSize = CGSizeMake(6, 16);
    _pageControl4.controlSpacing = 4;
    _pageControl4.pageAliment = PageControlRight;
    //   _pageControl4.currentBkImg=[UIImage imageNamed:@"bkimg"];
    _pageControl4.delegate = self;
    _pageControl4.tag = 904;
    [self.view addSubview:_pageControl4];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;

    if(scrollView.tag == 1001){
        self.pageControl1.currentPage = currentPage;
    }else if(scrollView.tag == 1002){
        self.pageControl2.currentPage = currentPage;
        
    }else if(scrollView.tag == 1003){
        self.pageControl3.currentPage = currentPage;
        
    }else if(scrollView.tag == 1004){
        self.pageControl4.currentPage = currentPage;
    }
}

#pragma mark --------------------------------------------------
#pragma mark - 代理
- (void)xh_PageControlClick:(XHPageControl*)pageControl index:(NSInteger)clickIndex{

    NSLog(@"%ld",clickIndex);
    if(pageControl.tag == 901) {
        CGPoint position = CGPointMake([UIScreen mainScreen].bounds.size.width * clickIndex, 0);
        [_scrollView1 setContentOffset:position animated:YES];
        
    }else if(pageControl.tag == 902){
        CGPoint position = CGPointMake([UIScreen mainScreen].bounds.size.width * clickIndex, 0);
        [_scrollView2 setContentOffset:position animated:YES];
    }else if(pageControl.tag == 903){
        CGPoint position = CGPointMake([UIScreen mainScreen].bounds.size.width * clickIndex, 0);
        [_scrollView3 setContentOffset:position animated:YES];
    }else if(pageControl.tag == 904){
        CGPoint position = CGPointMake([UIScreen mainScreen].bounds.size.width * clickIndex, 0);
        [_scrollView4 setContentOffset:position animated:YES];
    }
}






- (UIImageView *)createImgView:(int)index{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"pic-%d",index]]];
    imgV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * (index-1), 0, [UIScreen mainScreen].bounds.size.width, 100);
    imgV.layer.borderWidth = 1;
    return imgV;
}


@end
