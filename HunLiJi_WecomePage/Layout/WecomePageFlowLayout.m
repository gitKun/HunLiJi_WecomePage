//
//  WecomePageFlowLayout.m
//  HunLiJi_WecomePage
//
//  Created by DR_Kun on 2018/5/21.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "WecomePageFlowLayout.h"
#import "PageLayoutAttributes.h"

@interface WecomePageFlowLayout ()

/**** cell的总数 ***/
@property (nonatomic, assign) NSInteger cellCount;

@property (nonatomic, copy) NSArray *attributsArray;

@end

@implementation WecomePageFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
}
//告诉 layout 使用 自定义的 attributes 来布局
+ (Class)layoutAttributesClass {
    return [PageLayoutAttributes class];
}


/*!
 *  多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

//重写方法
// 这个方法返回所有的布局所需对象,瀑布流也可以重写这个方法实现.
//1.返回rect中的所有的元素的布局属性
//2.返回的是包含UICollectionViewLayoutAttributes的NSArray
//3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
//1)layoutAttributesForCellWithIndexPath:
//2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
//3)layoutAttributesForDecorationViewOfKind:withIndexPath:
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //计算当前的偏移量
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    CGFloat offsetX = self.collectionView.contentOffset.x;
    NSInteger index = offsetX / width;
    PageLayoutAttributes *curretnAttribute = self.attributsArray[index];
    PageLayoutAttributes *nextAttribute = nil;
    if (index < _cellCount -1) {
        nextAttribute = self.attributsArray[index + 1];
    }
    //当前的item对应的attribute设置偏移量为0
    curretnAttribute.contentOffsetX = 0;
    if (nextAttribute) {
        //正在出现的item对应的attribute设置偏移量为跟随collectionView的offset动态计算
        nextAttribute.contentOffsetX = -(width * 0.5 - (offsetX - width * index) * 0.5);
    }
    return self.attributsArray;
}

#pragma mark -- tools

- (NSArray *)attributsArray {
    if (!_attributsArray) {
        NSMutableArray *array = [NSMutableArray array];
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
        for (NSInteger i = 0; i < _cellCount; i++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            PageLayoutAttributes *attribute = [PageLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attribute.contentOffsetX = (i == 0 ? 0 : -(CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5));
            attribute.frame = CGRectMake(i * width, 0, width, height);
            [array addObject:attribute];
        }
        self.attributsArray = [array copy];
    }
    return _attributsArray;
}

@end
