# DYMarqueeView

## 简介
一个可以高度自定义的iOS跑马灯。

功能点：


1.高度自定义视图。

2.适用多种跑马灯应用场景。

3.代码简单，扩展便捷。

![dicImg](https://github.com/duyi56432/DYMarqueeView/blob/master/效果图.gif)  

## 博客
[这里有更详细用法](https://www.jianshu.com/p/3960b52b7358)

## 安装

使用 cocoapods
<pre><code> 
pod 'DYMarqueeView'
</code></pre>
当前最新版本1.0.0，如果不能搜索最新版本，执行命令 pod setup更新pod后再试。

持续优化中，如果有好的建议和意见欢迎交流，QQ群:433212576
## 用法
类似于UITableView,详细用法见Demo。
<pre><code> 

/**
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
    if (marqueeView.tag == 1000 ) {
        return self.view.bounds.size.width;
    }
    return 50;
}

</code></pre>

