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
@interface ARListView : UIScrollView

@property (nonatomic, strong, readonly) ARListViewLayout *layout;
@property (nonatomic, weak) id<ARListViewDelegate,UIScrollViewDelegate> delegate;
@property (nonatomic, weak) id<ARListViewDataSource> dataSource;

- (instancetype)initWithLayout:(ARListViewLayout *)layout NS_DESIGNATED_INITIALIZER;


- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

@end

@protocol ARListViewDataSource <NSObject>

@optional
- (NSUInteger)numberOfSectionsInListView:(ARListView *)listView;

@required
- (NSUInteger)listView:(ARListView *)listView numberOfItemsInSection:(NSUInteger)section;
- (__kindof ARListViewItem *)listView:(ARListView *)listView itemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ARListViewDelegate <NSObject>


@end
