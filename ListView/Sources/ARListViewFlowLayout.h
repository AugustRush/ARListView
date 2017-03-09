//
//  ARListViewFlowLayout.h
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayout.h"

typedef NS_ENUM(NSUInteger, ARListViewFlowLayoutItemAlign) {
    ARListViewFlowLayoutItemAlignStart,
    ARListViewFlowLayoutItemAlignCenter,
    ARListViewFlowLayoutItemAlignEnd
};

typedef NS_ENUM(NSUInteger, ARListViewScrollDirection) {
    ARListViewScrollDirectionVertical,
    ARListViewScrollDirectionHorizontal
};

@class ARListViewFlowLayout;
@protocol ARListViewFlowLayoutDelegate <NSObject>

@required
- (CGSize)flowLayout:(ARListViewFlowLayout *)flowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ARListViewFlowLayout : ARListViewLayout

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumItemSpacing;
@property (nonatomic, assign) ARListViewFlowLayoutItemAlign itemAlign;
@property (nonatomic, assign) ARListViewScrollDirection scrollDirection;

- (instancetype)initWithDelegate:(id<ARListViewFlowLayoutDelegate>)delegate;

@end
