//
//  WecomePageCell.m
//  HunLiJi_WecomePage
//
//  Created by DR_Kun on 2018/5/17.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "WecomePageCell.h"
#import "PageLayoutAttributes.h"

@interface WecomePageCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offsetX;
@property (weak, nonatomic) IBOutlet UIImageView *cImageView;

@end

@implementation WecomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

//使用LayoutAttributes布局Cell
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[PageLayoutAttributes class]]) {
        self.offsetX.constant = [(PageLayoutAttributes *)layoutAttributes contentOffsetX];
    }
}

#pragma mark === public
- (void)updateImage:(UIImage *)image {
    [self.cImageView setImage:image];
}

@end
