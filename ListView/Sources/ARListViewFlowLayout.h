//
//  ARListViewFlowLayout.h
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayout.h"

typedef NS_ENUM(NSUInteger, ARListViewFlowLayoutSectionAlign) {
    ARListViewFlowLayoutSectionAlignVertical,
    ARListViewFlowLayoutSectionAlignHorizonal,
};

@class ARListViewFlowLayout;
@protocol ARListViewFlowLayoutDelegate <NSObject>

- (CGSize)flowLayout:(ARListViewFlowLayout *)flowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ARListViewFlowLayout : ARListViewLayout

@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) ARListViewFlowLayoutSectionAlign sectionAlign;

- (instancetype)initWithDelegate:(id<ARListViewFlowLayoutDelegate>)delegate;

@end
