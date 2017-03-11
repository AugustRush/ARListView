//
//  ARListViewLayout.h
//  ListView
//
//  Created by AugustRush on 2017/3/8.
//  Copyright © 2017年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ARListView;
@class ARListViewLayoutItemAttributes;
@interface ARListViewLayout : NSObject

@property (nonatomic, readonly) ARListView *listView;
// subclass should override methods
- (void)preparedLayout;
- (nullable NSArray<__kindof ARListViewLayoutItemAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
- (ARListViewLayoutItemAttributes *)layoutAttributesAtIndexPath:(NSIndexPath *)indexPath;
- (void)finishedLayout;
//
- (CGSize)listViewContentSize;

@end

NS_ASSUME_NONNULL_END
