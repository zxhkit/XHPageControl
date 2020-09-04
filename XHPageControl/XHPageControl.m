//
//  XHPageControl.m
//  XHPageControl
//
//  Created by xuanhe on 2019/1/2.
//  Copyright © 2019 xuanhe. All rights reserved.
//

#import "XHPageControl.h"
@interface XHPageControl ()<XHPageControlDelegate>


@end
@implementation XHPageControl

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initialize];
    }
    return self;
}
- (void)initialize{
    self.backgroundColor = [UIColor clearColor];
    _otherMultiple = 1;
    _currentMultiple = 2;
    _numberOfPages = 0;
    _currentPage = 0;
    _controlSize = 6;
    _controlSpacing = 8;
    _otherColor = [UIColor grayColor];
    _currentColor = [UIColor orangeColor];
    _type = PageControlMiddle;
}

- (void)setOtherColor:(UIColor *)otherColor{
    if(![self isTheSameColor:otherColor anotherColor:_otherColor]){
        _otherColor = otherColor;
        [self createPointView];
    }
}

- (void)setCurrentColor:(UIColor *)currentColor{
    if(![self isTheSameColor:currentColor anotherColor:_currentColor]){
        _currentColor = currentColor;
        [self createPointView];
    }
}

- (void)setControlSize:(NSInteger)controlSize{
    if(_controlSize != controlSize){
        _controlSize = controlSize;
        [self createPointView];
    }
}
- (void)setOtherMultiple:(NSInteger)otherMultiple {
    if (otherMultiple != _otherMultiple) {
        _otherMultiple = otherMultiple;
        [self createPointView];
    }
}
- (void)setCurrentMultiple:(NSInteger)currentMultiple {
    if (currentMultiple != _currentMultiple) {
        _currentMultiple = currentMultiple;
        [self createPointView];
    }
}

- (void)setControlSpacing:(NSInteger)controlSpacing {
    if(_controlSpacing != controlSpacing){
        _controlSpacing = controlSpacing;
        [self createPointView];
    }
}

- (void)setCurrentBkImg:(UIImage *)currentBkImg {
    if(_currentBkImg != currentBkImg){
        _currentBkImg = currentBkImg;
        [self createPointView];
    }
}

- (void)setOtherBkImg:(UIImage *)otherBkImg {
    if (_otherBkImg != otherBkImg) {
        _otherBkImg = otherBkImg;
        [self createPointView];
    }
}

- (void)setType:(XHPageControlType)type {
    if (_type != type) {
        _type = type;
        [self createPointView];
    }
}

- (void)setNumberOfPages:(NSInteger)page {
    if(_numberOfPages == page){
        return;
    }
    _numberOfPages = page;
    [self createPointView];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    
    if([self.delegate respondsToSelector:@selector(xh_PageControlClick:index:)]) {
        [self.delegate xh_PageControlClick:self index:currentPage];
    }
    
    if(_currentPage == currentPage){
        return;
    }
    
    [self exchangeCurrentView:_currentPage new:currentPage];
    _currentPage = currentPage;
}

- (void)clearView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)createPointView {
    [self clearView];
    if(_numberOfPages <= 0)
        return;
    
    //居中控件
    CGFloat startX = 0;
    CGFloat startY = 0;
    CGFloat mainWidth = (_numberOfPages - 1)* _controlSize*_otherMultiple+ (_numberOfPages - 1) * _controlSpacing + _controlSize * _currentMultiple;
    if(self.frame.size.width < mainWidth){
        startX = 0;
    }else{
        if (_type == PageControlLeft) {
            startX = 10;
        }else if (_type == PageControlMiddle){
            startX = (self.frame.size.width - mainWidth)/2.0;
        }else if (_type == PageControlRight){
            startX = self.frame.size.width - mainWidth - 10;
        }
    }
    if(self.frame.size.height < _controlSize){
        startY = 0;
    }else{
        startY = (self.frame.size.height-_controlSize)/2;
    }
    //动态创建点
    for (int page = 0; page < _numberOfPages; page++) {
        if(page == _currentPage){
            UIView *currPointView = [[UIView alloc]initWithFrame:CGRectMake(startX, startY, _controlSize*_currentMultiple, _controlSize)];
            currPointView.layer.cornerRadius = _controlSize/2;
            currPointView.tag = page+1000;
            currPointView.backgroundColor = _currentColor;
            currPointView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [currPointView addGestureRecognizer:tapGesture];
            [self addSubview:currPointView];
            startX = CGRectGetMaxX(currPointView.frame)+_controlSpacing;
            
            if(_currentBkImg){
                currPointView.backgroundColor = [UIColor clearColor];
                UIImageView *currBkImg = [[UIImageView alloc]init];
                currBkImg.tag = 2233;
                currBkImg.frame = CGRectMake(0, 0, currPointView.frame.size.width, currPointView.frame.size.height);
                currBkImg.image = _currentBkImg;
                [currPointView addSubview:currBkImg];
            }
            
        }else{
            UIView *otherPointView = [[UIView alloc]initWithFrame:CGRectMake(startX, startY, _controlSize * _otherMultiple, _controlSize)];
            otherPointView.backgroundColor = _otherColor;
            otherPointView.tag = page+1000;
            otherPointView.layer.cornerRadius = _controlSize/2.0;
            otherPointView.userInteractionEnabled = YES;
            
            if (_otherBkImg) {
                otherPointView.backgroundColor = [UIColor clearColor];
                UIImageView *otherBkImg = [[UIImageView alloc] init];
                otherBkImg.tag = page+1000+2244;
                otherBkImg.frame = CGRectMake(0, 0, otherPointView.frame.size.width, otherPointView.frame.size.height);
                otherBkImg.image = _otherBkImg;
                [otherPointView addSubview:otherBkImg];
            }
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            [self addSubview:otherPointView];
            startX = CGRectGetMaxX(otherPointView.frame)+_controlSpacing;
        }
    }
}

//切换当前的点
- (void)exchangeCurrentView:(NSInteger)old new:(NSInteger)new {
    UIView *oldSelect = [self viewWithTag:1000+old];
    CGRect mpSelect = oldSelect.frame;
    
    UIView *newSeltect = [self viewWithTag:1000+new];
    CGRect newTemp = newSeltect.frame;
    
    if(_currentBkImg){
        UIView *imgview = [oldSelect viewWithTag:2233];
        [imgview removeFromSuperview];
        
        newSeltect.backgroundColor=[UIColor clearColor];
        UIImageView *currBkImg = [UIImageView new];
        currBkImg.tag = 2233;
        currBkImg.frame = CGRectMake(0, 0, mpSelect.size.width, mpSelect.size.height);
        currBkImg.image = _currentBkImg;
        [newSeltect addSubview:currBkImg];
    }
    if (_otherBkImg) {
        UIView *imgview=[newSeltect viewWithTag:2244+1000+new];
        [imgview removeFromSuperview];
        
        oldSelect.backgroundColor = [UIColor clearColor];
        UIImageView *otherBkImg = [UIImageView new];
        otherBkImg.tag = 2244+1000+new;
        otherBkImg.frame = CGRectMake(0, 0, mpSelect.size.width, mpSelect.size.height);
        otherBkImg.image = _otherBkImg;
        [oldSelect addSubview:otherBkImg];
    }
    oldSelect.backgroundColor = _otherColor;
    newSeltect.backgroundColor = _currentColor;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat lx=mpSelect.origin.x;
        if (new<old)
            lx+=self->_controlSize *(self->_currentMultiple - self->_otherMultiple);
        oldSelect.frame = CGRectMake(lx, mpSelect.origin.y, self->_controlSize * self->_otherMultiple, self->_controlSize);
        
        CGFloat mx = newTemp.origin.x;
        if (new>old)
            mx -= self->_controlSize * (self->_currentMultiple - self->_otherMultiple);
        newSeltect.frame = CGRectMake(mx, newTemp.origin.y, self->_controlSize * self->_currentMultiple, self->_controlSize);
        
        // 左边的时候到右边 越过点击
        if(new-old>1) {
            for(NSInteger t = old+1;t < new; t++) {
                UIView *ms = [self viewWithTag:1000+t];
                ms.frame=CGRectMake(ms.frame.origin.x-self->_controlSize * (self->_currentMultiple - self->_otherMultiple), ms.frame.origin.y, self->_controlSize*self->_otherMultiple, self->_controlSize);
            }
        }
        // 右边选中到左边的时候 越过点击
        if(new-old<-1) {
            for(NSInteger t = new+1; t < old; t++) {
                UIView *ms = [self viewWithTag:1000+t];
                ms.frame = CGRectMake(ms.frame.origin.x+self->_controlSize * (self->_currentMultiple - self->_otherMultiple), ms.frame.origin.y, self->_controlSize*self->_otherMultiple, self->_controlSize);
            }
        }
    }];
}

- (void)clickAction:(UITapGestureRecognizer*)recognizer{
    
    NSInteger index = recognizer.view.tag-1000;
    NSLog(@"-----:%ld",(long)index);
    [self setCurrentPage:index];
}

- (BOOL)isTheSameColor:(UIColor*)color1 anotherColor:(UIColor*)color2{
    return CGColorEqualToColor(color1.CGColor, color2.CGColor);
}


@end
