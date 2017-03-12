//
//  ARListViewLayoutItemAttributes+Yoga.m
//  ListView
//
//  Created by AugustRush on 2017/3/12.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayoutItemAttributes+Yoga.h"
#import "YGLayout+Private.h"
#import <objc/runtime.h>

static const void *kYGYogaAssociatedKey = &kYGYogaAssociatedKey;
@implementation ARListViewLayoutItemAttributes (Yoga)

- (YGLayout *)yoga
{
    YGLayout *yoga = objc_getAssociatedObject(self, kYGYogaAssociatedKey);
    if (!yoga) {
        yoga = [[YGLayout alloc] initWithView:self];
        objc_setAssociatedObject(self, kYGYogaAssociatedKey, yoga, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return yoga;
}

- (void)configureLayoutWithBlock:(YGLayoutConfigurationBlock)block
{
    if (block != nil) {
        block(self.yoga);
    }
}

- (CGSize)measureSizeThatFitsSize:(CGSize)size {
    return (CGSize) {
        .width = CGRectGetWidth(self.frame),
        .height = CGRectGetHeight(self.frame),
    };
}

- (BOOL)isLeaf
{
    return YES;
}

- (NSArray<id<YogaLayoutable>> *)leafNodes {
    return @[];
}

@end
