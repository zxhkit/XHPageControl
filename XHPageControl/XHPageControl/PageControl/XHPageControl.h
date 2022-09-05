//
//  XHPageControl.h
//  XHPageControl
//
//  Created by xuanhe on 2022/9/2.
//  github:https://github.com/zxhkit/XHPageControl
//  简书:https://www.jianshu.com/p/aae83cfaeeb4
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,XHPageControlType){
    PageControlMiddle = 0, //
    PageControlRight, //
    PageControlLeft //
};


@class XHPageControl;
@protocol XHPageControlDelegate <NSObject>

@optional

/// 点击PageControl点的时候,响应事件回调
/// @param pageControl 点击的pageControl
/// @param clickIndex 点击点的下标,从0开始
- (void)xh_PageControlClick:(XHPageControl*)pageControl index:(NSInteger)clickIndex;

@end
@interface XHPageControl : UIControl

/// 代理
@property (nonatomic, weak)     id<XHPageControlDelegate > delegate;
/// Block点击回调
@property (nonatomic, copy)     void (^clickPointBlock)(NSInteger index);


/// 控件位置,默认中间:PageControlMiddle
@property (nonatomic, assign)   XHPageControlType pageAliment;

/// 当前点的大小默认:(6,6)
@property (nonatomic, assign)   CGSize            currentPointSize;

/// 其他点的大小,默认:(6,6)
@property (nonatomic, assign)   CGSize            otherPointSize;

/// 圆角大小,默认:3
@property (nonatomic, assign)   CGFloat           pointCornerRadius;

/// 分页数量
@property (nonatomic, assign)   NSInteger         numberOfPages;

/// 当前点所在下标
@property (nonatomic, assign)   NSInteger         currentPage;

/// 两点间的间距
@property (nonatomic, assign)   CGFloat           controlSpacing;

/// 左右间宽,只有在居左居右显示的时候才有用
@property (nonatomic, assign)   CGFloat           leftAndRightSpacing;

/// 其他未选中点颜色
@property (nonatomic, strong)   UIColor          *otherColor;

/// 当前点颜色
@property (nonatomic, strong)   UIColor          *currentColor;

///其他选中点的layer边框颜色
@property (nonatomic, strong)   UIColor          *otherLayerBorderColor;

///当前选中点的layer边框颜色
@property (nonatomic, strong)   UIColor          *currentLayerBorderColor;

///其他点的layer宽
@property (nonatomic, assign)   CGFloat           otherLayerBorderWidth;

///当前选中点的layer宽
@property (nonatomic, assign)   CGFloat           currentLayerBorderWidth;

/// 当前点背景图片
@property (nonatomic, strong)   UIImage          *currentBkImage;

/// 其他点背景图片
@property (nonatomic, strong)   UIImage          *otherBkImage;

/// 当只有一个点的时候是否隐藏,默认隐藏
@property (nonatomic, assign)   BOOL             isHidesForSinglePage;

/// 是否可以点击,默认不可以点击
@property (nonatomic, assign)   BOOL             isCanClickPoint;









@end

NS_ASSUME_NONNULL_END
