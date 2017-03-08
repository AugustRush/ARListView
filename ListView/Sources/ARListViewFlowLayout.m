//
//  ARListViewFlowLayout.m
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewFlowLayout.h"
#import "ARListViewLayoutItemAttributes.h"
#import "ARListView.h"

@implementation ARListViewFlowLayout {
    id<ARListViewFlowLayoutDelegate> _delegate;
}

- (instancetype)initWithDelegate:(id<ARListViewFlowLayoutDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _itemInset = 1.0;
    }
    return self;
}

- (ARListViewLayoutItemAttributes *)attributesAtIndexPath:(NSIndexPath *)indexPath {
    static CGFloat x = 0.0;
    static CGFloat y = 0.0;
    
    ARListViewLayoutItemAttributes *attributes = [[ARListViewLayoutItemAttributes alloc] init];
    CGSize size = [_delegate flowLayout:self sizeForItemAtIndexPath:indexPath];
    attributes.frame = CGRectMake(x, y, size.width, size.height);
    y += size.height + _itemInset;
    return attributes;
}

@end
