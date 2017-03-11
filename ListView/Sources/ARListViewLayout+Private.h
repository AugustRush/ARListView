//
//  ARListViewLayout+Private.h
//  ListView
//
//  Created by AugustRush on 2017/3/11.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayout.h"

NS_ASSUME_NONNULL_BEGIN
@class ARListView;
@interface ARListViewLayout (Private)

- (void)setListView:(ARListView *)listView;
- (NSMutableArray *)__attributesCachedArrayForSection:(NSUInteger)section;
- (void)__cachedAttributes:(ARListViewLayoutItemAttributes *)attributes atIndexPath:(NSIndexPath *)indexPath;
- (nullable ARListViewLayoutItemAttributes *)__getCachedAttributesAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
