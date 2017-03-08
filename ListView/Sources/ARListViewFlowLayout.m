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
    CGFloat _calculateX;
    CGFloat _calculateY;
}

- (instancetype)initWithDelegate:(id<ARListViewFlowLayoutDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _minimumLineSpacing = 1.0;
        _itemAlign = ARListViewFlowLayoutItemAlignEnd;
    }
    return self;
}

- (void)preparedLayout {
    _calculateX = 0.0;
    _calculateY = _minimumLineSpacing;
}

- (ARListViewLayoutItemAttributes *)layoutAttributesAtIndexPath:(NSIndexPath *)indexPath {
    
    ARListViewLayoutItemAttributes *attributes = [[ARListViewLayoutItemAttributes alloc] init];
    CGSize size = [_delegate flowLayout:self sizeForItemAtIndexPath:indexPath];
    switch (_itemAlign) {
        case ARListViewFlowLayoutItemAlignStart:{
            attributes.frame = CGRectMake(_calculateX, _calculateY, size.width, size.height);
            _calculateY += size.height + _minimumLineSpacing;
            break;
        }
        case ARListViewFlowLayoutItemAlignCenter:{
            _calculateX = CGRectGetMidX(self.listView.bounds) - size.width/2.0;
            attributes.frame = CGRectMake(_calculateX, _calculateY, size.width, size.height);
            _calculateY += size.height + _minimumLineSpacing;
            break;
        }
        case ARListViewFlowLayoutItemAlignEnd:{
            _calculateX = CGRectGetMaxX(self.listView.bounds) - size.width;
            attributes.frame = CGRectMake(_calculateX, _calculateY, size.width, size.height);
            _calculateY += size.height + _minimumLineSpacing;
            break;
        }
            
        default:
            break;
    }
    return attributes;
}

- (void)finishedLayout {
    _calculateX = 0;
    _calculateY = 0;
}

@end
