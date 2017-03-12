//
//  ARListViewYogaLayoutRootAttributes.m
//  ListView
//
//  Created by AugustRush on 2017/3/12.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewYogaLayoutRootAttributes.h"

@implementation ARListViewYogaLayoutRootAttributes {
    NSMutableArray<ARListViewLayoutItemAttributes *> *_leafNodes;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _leafNodes = [NSMutableArray array];
    }
    return self;
}

- (void)addLeafAttributes:(ARListViewLayoutItemAttributes *)attr {
    [_leafNodes addObject:attr];
}

- (void)removeAllAttributes {
    [_leafNodes removeAllObjects];
}

- (BOOL)isLeaf {
    return NO;
}

- (NSArray<id<YogaLayoutable>> *)leafNodes {
    return _leafNodes;
}

@end
