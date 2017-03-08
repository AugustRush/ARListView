//
//  ARListViewFlowLayout.h
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayout.h"

@class ARListViewFlowLayout;
@protocol ARListViewFlowLayoutDelegate <NSObject>

- (CGSize)flowLayout:(ARListViewFlowLayout *)flowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ARListViewFlowLayout : ARListViewLayout

@property (nonatomic, assign) CGFloat itemInset;

- (instancetype)initWithDelegate:(id<ARListViewFlowLayoutDelegate>)delegate;

@end
