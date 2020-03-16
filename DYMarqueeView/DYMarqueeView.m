//
//  DYMarqueeView.m
//  DYMarqueeViewDemo
//
//  Created by ddyy on 2020/1/6.
//  Copyright © 2020 ddyy. All rights reserved.
//

#import "DYMarqueeView.h"

@interface DYMarqueeView ()
@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) double stepLength;
@property (strong, nonatomic) CADisplayLink *link;
@property (assign, nonatomic) NSInteger numberRows;
@property (assign, nonatomic) CGFloat totalCellWidth;
@property (strong, nonatomic) NSMutableArray *cellArray;
@end

@implementation DYMarqueeView

- (instancetype)initWithFrame:(CGRect)frame ScrollDirection:(DYScrollDirection)scrollDirection {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollDirection = scrollDirection;
        [self loadUI];
    }
    return self;
}

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAnimation)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        if (@available(iOS 10.0, *)) {
            //一秒内执行多少次方法，默认60
            _link.preferredFramesPerSecond = 60;
        } else {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            //多少次屏幕刷新后才调用一次方法,ios10.0后被废弃。默认刷新一次调用一次
            _link.frameInterval = 1;
            #pragma clang diagnostic pop
        }
    }
    return _link;
}

- (NSMutableArray *)cellArray {
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

- (void)startScroll {
    if (!_delegate || _animationDuration == 0.0) return;
    [self link];
    _stepLength = self.bounds.size.width / (_animationDuration * 60);
}

- (void)setDelegate:(id<DYMarqueeViewDelagete>)delegate {
    _delegate = delegate;
    [self delegateConfig];
}

- (void)loadUI {
    _numberRows = 1;
    _animationDuration = 5.0;
    _totalCellWidth = 0.0;
    _backView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_backView];
    [self delegateConfig];
}

- (void)delegateConfig {
    if ([self.delegate respondsToSelector:@selector(numberOfMarqueeView:)]) {
        _numberRows = [self.delegate numberOfMarqueeView:self];
    } else {
        return ;
    }
    self.backView.transform = CGAffineTransformMakeScale(_scrollDirection, 1);

    for (int i = 0; i < self.bounds.size.width / _totalCellWidth + 1; i++) {
        [self addCellBackView:i];
    }
}

- (void)addCellBackView:(NSInteger)index {
    CGFloat pointx = 0.0;
    _totalCellWidth = 0;
    NSMutableArray *viewArray = [NSMutableArray array];
    UIView *cellBackView = [[UIView alloc] init];
    for (int i = 0; i < _numberRows; i++) {
        if ([self.delegate respondsToSelector:@selector(marqueeView:cellViewWithIndexPath:)]) {
            UIView *view = [self.delegate marqueeView:self cellViewWithIndexPath:[NSIndexPath indexPathForRow:i inSection:index]];
            [viewArray addObject:view];
        }
        
        if ([self.delegate respondsToSelector:@selector(marqueeView:widthCellWithIndex:)]) {
            CGFloat width = [self.delegate marqueeView:self widthCellWithIndex:i];
            _totalCellWidth += width;
            UIView *view = viewArray[i];
            view.transform = CGAffineTransformMakeScale(_scrollDirection, 1);
            view.frame = CGRectMake(pointx, 0, width, self.bounds.size.height);
            [cellBackView addSubview:view];
            pointx += width;
        }
    }
    [self.cellArray addObject:viewArray];
    cellBackView.frame = CGRectMake(_totalCellWidth * index, 0, _totalCellWidth, self.bounds.size.height);
    [self.backView addSubview:cellBackView];
}

- (void)resetAnimation {
    if (!_delegate) return;
    [_link invalidate];
    _link = nil;
    [self link];
}

- (void)startAnimation {
    if (self.animating) return;
    CGRect rect = self.backView.bounds;
    CGFloat originx = rect.origin.x;
    
    if (originx >= self.totalCellWidth &&
        originx < self.totalCellWidth + _stepLength) {
        self.backView.bounds = CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height);
        return;
    }
    
    //需要停顿的情况
    CGFloat waitx = (int)originx % (int)self.bounds.size.width;
    if (self.waitDuration > 0.0 && waitx >= 0 && waitx < _stepLength) {
        _animating = YES;
        if (self.waitDuration > 0.0) {
            [self performSelector:@selector(afterAnimation) withObject:nil afterDelay:self.waitDuration];
        }
    } else {
        self.backView.bounds = CGRectMake(rect.origin.x + _stepLength, rect.origin.y, rect.size.width, rect.size.height);
    }
}

- (void)afterAnimation {
    CGRect rect = self.backView.bounds;
    self.backView.bounds = CGRectMake(rect.origin.x + self.stepLength, rect.origin.y, rect.size.width, rect.size.height);
    _animating = NO;
}
#pragma mark -

- (UIView *)dequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath {
    if (self.cellArray.count <= indexPath.section) return nil;
   return self.cellArray[indexPath.section][indexPath.row];
}

- (void)reloadData {
    for (int i = 0; i < self.cellArray.count; i++) {
        NSArray *cellArray = self.cellArray[i];
        for (int j = 0; j < cellArray.count; j++) {
            if ([self.delegate respondsToSelector:@selector(marqueeView:cellViewWithIndexPath:)]) {
                [self.delegate marqueeView:self cellViewWithIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            }
        }
    }
}
@end

