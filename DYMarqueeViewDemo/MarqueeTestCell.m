//
//  MarqueeTestCell.m
//  DYMarqueeViewDemo
//
//  Created by 张小龙 on 2020/1/17.
//  Copyright © 2020 ddyy. All rights reserved.
//

#import "MarqueeTestCell.h"
#import "Masonry.h"

@implementation MarqueeTestCell

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor grayColor]][self.index];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return _button;
}

- (void)buttonClick:(UIButton *)button {
    NSLog(@"      %@",@(self.index));
}
@end
