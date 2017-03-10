//
//  ListView.h
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARListViewItem.h"
#import "ARListViewFlowLayout.h"

@protocol ARListViewLayoutProtocol;
@protocol ARListViewDataSource;
@protocol ARListViewDelegate;
NS_ASSUME_NONNULL_BEGIN
@interface ARListView : UIScrollView

@property (nonatomic, strong, readonly) ARListViewLayout *layout;
@property (nonatomic, weak) id<ARListViewDelegate,UIScrollViewDelegate> delegate;
@property (nonatomic, weak) id<ARListViewDataSource> dataSource;
@property (nonatomic, readonly) NSSet<__kindof ARListViewItem *> *visibleItems;

- (instancetype)initWithLayout:(ARListViewLayout *)layout NS_DESIGNATED_INITIALIZER;
//
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (void)reloadData;
- (nullable ARListViewLayoutItemAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)registerClass:(Class)itemClass forCellReuseIdentifier:(nonnull NSString *)identifier;
- (__kindof ARListViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;
//
- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
@end

@protocol ARListViewDataSource <NSObject>

@optional
- (NSUInteger)numberOfSectionsInListView:(ARListView *)listView;

@required
- (NSUInteger)listView:(ARListView *)listView numberOfItemsInSection:(NSUInteger)section;
- (__kindof ARListViewItem *)listView:(ARListView *)listView itemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ARListViewDelegate <NSObject,UIScrollViewDelegate>

@optional
- (void)listView:(ARListView *)listView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
