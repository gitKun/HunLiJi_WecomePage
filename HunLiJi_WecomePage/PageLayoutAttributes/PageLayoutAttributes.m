//
//  PageLayoutAttributes.m
//  HunLiJi_WecomePage
//
//  Created by DR_Kun on 2018/5/17.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "PageLayoutAttributes.h"

@implementation PageLayoutAttributes

/*
 这个方法中值有两种返回结果:
 1.return NO;
 2.return [super isEqual:object];
 具体区别可以打开 #if 查看效果
 */
- (BOOL)isEqual:(id)object {
    /*
     //这里的判断永远是不相等的(仅本例)
    if (self == object) {
        return YES;
    }
     */
    if ([object isKindOfClass:[PageLayoutAttributes class]]) {
        PageLayoutAttributes *newObject = (PageLayoutAttributes *)object;
#if 1
        if (newObject.contentOffsetX != self.contentOffsetX) {
            return NO;
        }
#else
        if (newObject.contentOffsetX == self.contentOffsetX) {
            return YES;
        }
#endif
        return [super isEqual:object];
    }
    return [super isEqual:object];
}

/*
 必须实现 copyWithZone 方法
 */
- (instancetype)copyWithZone:(NSZone *)zone {
    //父类已经实现了 NSCoping 协议,这里只需要调用父类中的实现(runtime知识:1.super和self 2.消息转发)
    PageLayoutAttributes *model = [super copyWithZone:zone];
    model.contentOffsetX = self.contentOffsetX;
    return model;
}

@end
