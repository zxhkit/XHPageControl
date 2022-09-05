//
//  XHPageControl.m
//  XHPageControl
//
//  Created by xuanhe on 2022/9/2.
//  github:https://github.com/zxhkit/XHPageControl
//  简书:https://www.jianshu.com/p/aae83cfaeeb4
//

#import "XHPageControl.h"
@interface XHPageControl ()<XHPageControlDelegate>


@end


@interface XHPageControl ()

@property (nonatomic, strong) NSMutableArray *dots;

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
    self.currentPointSize = CGSizeMake(6, 6);
    self.otherPointSize = CGSizeMake(12, 6);
    self.pointCornerRadius = 3;
    self.pageAliment = PageControlMiddle;
    self.numberOfPages = 0;
    self.currentPage = 0;
    self.controlSpacing = 8;
    self.leftAndRightSpacing = 10;
    self.otherColor = [UIColor grayColor];
    self.currentColor = [UIColor orangeColor];
    self.isHidesForSinglePage = YES;
    self.isCanClickPoint = NO;
    self.currentLayerBorderWidth = 1;
    self.otherLayerBorderWidth = 1;
    self.dots = [NSMutableArray array];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self createPointView];
}

- (void)setOtherColor:(UIColor *)otherColor{
    if (![self isTheSameColor:otherColor anotherColor:_otherColor]) {
        _otherColor = otherColor;
        [self createPointView];
    }
}

- (void)setCurrentColor:(UIColor *)currentColor{
    if (![self isTheSameColor:currentColor anotherColor:_currentColor]) {
        _currentColor = currentColor;
        [self createPointView];
    }
}

- (void)setCurrentPointSize:(CGSize)currentPointSize{
    if (!CGSizeEqualToSize(currentPointSize, _currentPointSize)) {
        _currentPointSize = currentPointSize;
        [self createPointView];
    }
}


- (void)setControlSpacing:(CGFloat)controlSpacing{
    if (_controlSpacing != controlSpacing){
        _controlSpacing = controlSpacing;
        [self createPointView];
    }
}

- (void)setCurrentBkImage:(UIImage *)currentBkImage{
    if (_currentBkImage != currentBkImage){
        _currentBkImage = currentBkImage;
        [self createPointView];
    }
}

- (void)setOtherBkImage:(UIImage *)otherBkImage {
    if (_otherBkImage != otherBkImage) {
        _otherBkImage = otherBkImage;
        [self createPointView];
    }
}

- (void)setPointCornerRadius:(CGFloat)pointCornerRadius{
    if (_pointCornerRadius != pointCornerRadius) {
        _pointCornerRadius = pointCornerRadius;
        [self createPointView];
    }
}

- (void)setPageAliment:(XHPageControlType)pageAliment{
    if (_pageAliment != pageAliment) {
        _pageAliment = pageAliment;
        [self createPointView];
    }
}


- (void)setNumberOfPages:(NSInteger)numberOfPages{
    if (_numberOfPages != numberOfPages) {
        _numberOfPages = numberOfPages;
        [self createPointView];
    }
}

- (void)setCurrentLayerBorderColor:(UIColor *)currentLayerBorderColor{
    if (![self isTheSameColor:currentLayerBorderColor anotherColor:_currentLayerBorderColor]) {
        _currentLayerBorderColor = currentLayerBorderColor;
        [self createPointView];
    }
}

- (void)setOtherLayerBorderColor:(UIColor *)otherLayerBorderColor{
    if (![self isTheSameColor:otherLayerBorderColor anotherColor:_otherLayerBorderColor]) {
        _otherLayerBorderColor = otherLayerBorderColor;
        [self createPointView];
    }
}

- (void)setCurrentLayerBorderWidth:(CGFloat)currentLayerBorderWidth{
    if (_currentLayerBorderWidth != currentLayerBorderWidth) {
        _currentLayerBorderWidth = currentLayerBorderWidth;
        [self createPointView];
    }
}

- (void)setOtherLayerBorderWidth:(CGFloat)otherLayerBorderWidth{
    if (_otherLayerBorderWidth != otherLayerBorderWidth) {
        _otherLayerBorderWidth = otherLayerBorderWidth;
        [self createPointView];
    }
}


- (void)setCurrentPage:(NSInteger)currentPage {
    
    if (_currentPage == currentPage){
        return;
    }
    
    [self exchangePointView:_currentPage newPage:currentPage];
    _currentPage = currentPage;
}

- (void)clearView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)createPointView {
    [self.dots removeAllObjects];
    [self clearView];
    if (_numberOfPages <= 0){
        return;
    }
    //居中控件
    CGFloat startX = 0;
    CGFloat startY_current = 0;
    CGFloat startY_other = 0;
    CGFloat mainWidth = (_numberOfPages - 1) * self.otherPointSize.width + (_numberOfPages - 1) * _controlSpacing + self.currentPointSize.width;
    if (self.frame.size.width < mainWidth){
        startX = 0;
    } else {
        if (_pageAliment == PageControlLeft) {
            startX = 10;
        }else if (_pageAliment == PageControlMiddle){
            startX = (self.frame.size.width - mainWidth)/2.0;
        }else if (_pageAliment == PageControlRight){
            startX = self.frame.size.width - mainWidth - 10;
        }else{
            NSAssert(1, @"请传入正确的pageAliment");
        }
    }
    
    CGFloat maxHeight = MAX(self.otherPointSize.height, self.currentPointSize.height);
    if (self.frame.size.height < maxHeight){
        CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, maxHeight);
        self.frame = rect;
        return;
    }else{
        startY_current = (CGRectGetHeight(self.frame) - maxHeight)/2.0 + (maxHeight - self.currentPointSize.height);
        startY_other = (CGRectGetHeight(self.frame) - maxHeight)/2.0 + (maxHeight - self.otherPointSize.height);
    }
    //动态创建点
    for (int page = 0; page < _numberOfPages; page++) {
        if(page == _currentPage){
            UIImageView *currentPoint = [[UIImageView alloc] initWithFrame:CGRectMake(startX, startY_current, self.currentPointSize.width, self.currentPointSize.height)];
            currentPoint.layer.cornerRadius = self.pointCornerRadius;
            currentPoint.tag = page+1000;
            currentPoint.backgroundColor = _currentColor;
            currentPoint.userInteractionEnabled = YES;
            currentPoint.image = self.currentBkImage;
            if (self.currentBkImage) {
                currentPoint.backgroundColor = [UIColor clearColor];
            }
            if (self.currentLayerBorderColor) {
                currentPoint.layer.borderColor = self.currentLayerBorderColor.CGColor;
                currentPoint.layer.borderWidth = self.currentLayerBorderWidth;
            }else{
                currentPoint.layer.borderWidth = 0;
            }
            
            if (self.isCanClickPoint) {
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
                [currentPoint addGestureRecognizer:tapGesture];
            }
            [self addSubview:currentPoint];
            startX = CGRectGetMaxX(currentPoint.frame) + _controlSpacing;
            
            [self.dots addObject:currentPoint];
        }else{
            UIImageView *otherPoint = [[UIImageView alloc] initWithFrame:CGRectMake(startX, startY_other, self.otherPointSize.width, self.otherPointSize.height)];
            otherPoint.layer.cornerRadius = self.pointCornerRadius;
            otherPoint.backgroundColor = _otherColor;
            otherPoint.tag = page+1000;
            otherPoint.userInteractionEnabled = YES;
            otherPoint.image = self.otherBkImage;
            if (self.otherBkImage) {
                otherPoint.backgroundColor = [UIColor clearColor];
            }
            
            if (self.otherLayerBorderColor) {
                otherPoint.layer.borderColor = self.otherLayerBorderColor.CGColor;
                otherPoint.layer.borderWidth = self.otherLayerBorderWidth;
            }else{
                otherPoint.layer.borderWidth = 0;
            }
            
            
            if (self.isCanClickPoint) {
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
                [otherPoint addGestureRecognizer:tapGesture];
                [self addSubview:otherPoint];
            }
            [self addSubview:otherPoint];
            startX = CGRectGetMaxX(otherPoint.frame) + _controlSpacing;
            [self.dots addObject:otherPoint];
        }
    }
}

- (void)clickAction:(UITapGestureRecognizer*)recognizer{
    
    NSInteger index = recognizer.view.tag-1000;
    NSLog(@"-----:%ld",(long)index);
    if (index >= 0 && index <= self.numberOfPages) {
        [self setCurrentPage:index];
        if ([self.delegate respondsToSelector:@selector(xh_PageControlClick:index:)]) {
            [self.delegate xh_PageControlClick:self index:index];
        }
    }
}

//切换当前的点
- (void)exchangePointView:(NSInteger)oldPage newPage:(NSInteger)newPage {
    if (oldPage == newPage) {
        return;
    }
    if (oldPage >= self.dots.count) {
        return;
    }
    if (newPage >= self.dots.count) {
        return;
    }
    
    UIImageView *theOldDot = self.dots[oldPage];
    CGRect theOldFrame = theOldDot.frame;
    
    UIImageView *theNewDot = self.dots[newPage];
    CGRect theNewFrame = theNewDot.frame;
    
    theNewDot.image = self.currentBkImage;
    if (self.currentBkImage) {
        theNewDot.backgroundColor = [UIColor clearColor];
    }else{
        theNewDot.backgroundColor = self.currentColor;
    }
    theOldDot.image = self.otherBkImage;
    if (self.otherBkImage) {
        theOldDot.backgroundColor = [UIColor clearColor];
    }else{
        theOldDot.backgroundColor = self.otherColor;
    }
    
    if (self.currentLayerBorderColor) {
        theNewDot.layer.borderColor = self.currentLayerBorderColor.CGColor;
        theNewDot.layer.borderWidth = self.currentLayerBorderWidth;
    }else{
        theNewDot.layer.borderWidth = 0;
    }
    if (self.otherLayerBorderColor) {
        theOldDot.layer.borderColor = self.otherLayerBorderColor.CGColor;
        theOldDot.layer.borderWidth = self.otherLayerBorderWidth;
    }else{
        theOldDot.layer.borderWidth = 0;
    }
    
    
    __block CGFloat oldMinX = CGRectGetMinX(theOldFrame);
    __block CGFloat newMinX = CGRectGetMinX(theNewFrame);
    
    [UIView animateWithDuration:0.25 animations:^{
        if (newPage < oldPage) {
            oldMinX = oldMinX + (self.currentPointSize.width - self.otherPointSize.width);
        }
        theOldDot.frame = CGRectMake(oldMinX, CGRectGetMinY(theNewFrame), self.otherPointSize.width, self.otherPointSize.height);
        
        if (newPage > oldPage) {
            newMinX = newMinX - (self.currentPointSize.width - self.otherPointSize.width);
        }
        theNewDot.frame = CGRectMake(newMinX, CGRectGetMinY(theOldFrame), self.currentPointSize.width, self.currentPointSize.height);
        
        if (newPage - oldPage > 1) {  //往右滑动
            for (NSInteger index = oldPage+1; index < newPage; index++) {
                if (index < self.dots.count) {
                    UIImageView *point = self.dots[index];
                    point.frame = CGRectMake(
                                             CGRectGetMinX(point.frame) - (self.currentPointSize.width - self.otherPointSize.width),
                                             CGRectGetMinY(point.frame),
                                             self.otherPointSize.width,
                                             self.otherPointSize.height);
                }else{
                    return;
                }
            }
        }
        if (newPage - oldPage < -1) {  //往左滑动
            for (NSInteger index = newPage+1; index < oldPage; index++) {
                if (index < self.dots.count) {
                    UIImageView *point = self.dots[index];
                    point.frame = CGRectMake(
                                             CGRectGetMinX(point.frame) + (self.currentPointSize.width-self.otherPointSize.width),
                                             CGRectGetMinY(point.frame),
                                             self.otherPointSize.width,
                                             self.otherPointSize.height);
                }else{
                    return;
                }
            }
        }
    }completion:^(BOOL finished) {
        if (finished == NO) {
            
            if (newPage < oldPage) {
                oldMinX = oldMinX + (self.currentPointSize.width - self.otherPointSize.width);
            }
            theOldDot.frame = CGRectMake(oldMinX, CGRectGetMinY(theNewFrame), self.otherPointSize.width, self.otherPointSize.height);
            
            if (newPage > oldPage) {
                newMinX = newMinX - (self.currentPointSize.width - self.otherPointSize.width);
            }
            theNewDot.frame = CGRectMake(newMinX, CGRectGetMinY(theOldFrame), self.currentPointSize.width, self.currentPointSize.height);
            
            if (newPage - oldPage > 1) {  //往右滑动
                for (NSInteger index = oldPage+1; index < newPage; index++) {
                    if (index < self.dots.count) {
                        UIImageView *point = self.dots[index];
                        point.frame = CGRectMake(
                                                 CGRectGetMinX(point.frame) - (self.currentPointSize.width - self.otherPointSize.width),
                                                 CGRectGetMinY(point.frame),
                                                 self.otherPointSize.width,
                                                 self.otherPointSize.height);
                    }else{
                        return;
                    }
                }
            }
            if (newPage - oldPage < -1) {  //往左滑动
                for (NSInteger index = newPage+1; index < oldPage; index++) {
                    if (index < self.dots.count) {
                        UIImageView *point = self.dots[index];
                        point.frame = CGRectMake(
                                                 CGRectGetMinX(point.frame) + (self.currentPointSize.width-self.otherPointSize.width),
                                                 CGRectGetMinY(point.frame),
                                                 self.otherPointSize.width,
                                                 self.otherPointSize.height);
                    }else{
                        return;
                    }
                }
            }
        }
    }];
}

- (BOOL)isTheSameColor:(UIColor*)color1 anotherColor:(UIColor*)color2{
    return CGColorEqualToColor(color1.CGColor, color2.CGColor);
}


@end
