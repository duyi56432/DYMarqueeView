//
//  ViewController.m
//  DYMarqueeViewDemo
//
//  Created by 张小龙 on 2020/1/6.
//  Copyright © 2020 ddyy. All rights reserved.
//

#import "ViewController.h"
#import "DYMarqueeView.h"
#import "MarqueeTestCell.h"

@interface ViewController () <DYMarqueeViewDelagete>
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) DYMarqueeView *view0;
@property (strong, nonatomic) DYMarqueeView *view1;
@property (strong, nonatomic) DYMarqueeView *view2;
@property (strong, nonatomic) DYMarqueeView *view3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@"cell0",@"cell1",@"cell2",@"cell3"];
    
    _view0 = [[DYMarqueeView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 20) ScrollDirection:DYScrollDirectionLeft];
    _view0.delegate = self;
    [self.view addSubview:_view0];
    [_view0 startScroll];
    
    _view1 = [[DYMarqueeView alloc] initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 20) ScrollDirection:DYScrollDirectionRight];
    _view1.delegate = self;
    [self.view addSubview:_view1];
    [_view1 startScroll];

    _view2 = [[DYMarqueeView alloc] initWithFrame:CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 20) ScrollDirection:DYScrollDirectionLeft];
    _view2.tag = 1000;
    _view2.delegate = self;
    _view2.waitDuration = 1;
    [self.view addSubview:_view2];
    [_view2 startScroll];

    _view3 = [[DYMarqueeView alloc] initWithFrame:CGRectMake(0, 450, [UIScreen mainScreen].bounds.size.width, 20) ScrollDirection:DYScrollDirectionRight];
    _view3.tag = 1001;
    _view3.delegate = self;
    _view3.waitDuration = 1;
    [self.view addSubview:_view3];
    [_view3 startScroll];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.frame = CGRectMake(30, 600, self.view.bounds.size.width - 60, 40);
    reloadButton.layer.cornerRadius = 20;
    reloadButton.clipsToBounds = YES;
    [reloadButton setTitle:@"刷新数据" forState:UIControlStateNormal];
    reloadButton.backgroundColor = [UIColor orangeColor];
    [reloadButton addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reloadButton];
}

- (void)reloadData {
    _dataArray = @[@"test0",@"test1",@"test2",@"test3"];
    
    [_view0 reloadData];
    [_view1 reloadData];
    [_view2 reloadData];
    [_view3 reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //仅做示范，这里没有实际效果
    [_view0 resetAnimation];
}

#pragma mark - DYMarqueeViewDelagete

- (NSInteger)numberOfMarqueeView:(DYMarqueeView *)marqueeView {
    return 4;
}

- (UIView *)marqueeView:(DYMarqueeView *)marqueeView cellViewWithIndexPath:(NSIndexPath *)indexPath {
    MarqueeTestCell *cell = [marqueeView dequeueReusableCellWithIndexPath:indexPath];
    if (!cell) {
        cell = [[MarqueeTestCell alloc] init];
    }
    cell.index = indexPath.row;
    [cell.button setTitle:_dataArray[indexPath.row] forState:UIControlStateNormal];
    return cell;
}

- (CGFloat)marqueeView:(DYMarqueeView *)marqueeView widthCellWithIndex:(NSInteger)index {
    if (marqueeView.tag == 1000 || marqueeView.tag == 1001) {
        return self.view.bounds.size.width;
    }
    return [@[@(50),@(80),@(90),@(120)][index] doubleValue];
}

@end
