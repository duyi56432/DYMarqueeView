//
//  DYMarqueeView.h
//  DYMarqueeViewDemo
//
//  Created by ddyy on 2020/1/6.
//  Copyright © 2020 ddyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYMarqueeView;
NS_ASSUME_NONNULL_BEGIN

///滚动方向，如果需要使用竖直方向跑马灯，请使用DYScollTextView
typedef NS_ENUM(NSInteger, DYScrollDirection) {
    DYScrollDirectionLeft = 1,
    DYScrollDirectionRight = - 1
};

@protocol DYMarqueeViewDelagete <NSObject>

/// cell数量，分组是内部实现需要，不能设置分组。
- (NSInteger)numberOfMarqueeView:(DYMarqueeView *)marqueeView;

/// 每一个cell视图，需要自定义实现。
/// @param indexPath 如无需要，正常使用indexPath.row即可。
- (__kindof UIView *)marqueeView:(DYMarqueeView *)marqueeView cellViewWithIndexPath:(NSIndexPath *)indexPath;

/// 每个cell宽度。
/// @param index 无需设置indexPath.section。
- (CGFloat)marqueeView:(DYMarqueeView *)marqueeView widthCellWithIndex:(NSInteger)index;

@end

@interface DYMarqueeView : UIView

@property (assign, nonatomic, readonly) BOOL animating;

/// 动画时间，滑过self.width距离需要的时间，不包含停顿时间，默认5s。
@property (assign, nonatomic) double animationDuration;

/// 每个cell在父视图中点停顿时间，仅支持每个cell等宽，且宽度等于DYMarqueeView宽度时有效，默认0s。
@property (assign, nonatomic) double waitDuration;

/// 滚动方向.默认向左。
@property (assign, nonatomic) DYScrollDirection scrollDirection;

@property (weak, nonatomic) id<DYMarqueeViewDelagete> delegate;

- (instancetype)initWithFrame:(CGRect)frame ScrollDirection:(DYScrollDirection)scrollDirection;

- (__kindof UIView *)dequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath;

/// 重置CADisplayLink，可以解决页面转调后动画卡顿、停顿问题。
- (void)resetAnimation;

- (void)startScroll;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
