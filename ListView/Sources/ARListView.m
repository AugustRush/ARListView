//
//  ListView.m
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListView.h"
#import "ARListViewFlowLayout.h"
#import "ARListViewLayoutItemAttributes.h"
////
@interface ARListViewLayout (ARPrivate)

- (void)setListView:(ARListView *)listView;

@end
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation ARListViewLayout (ARPrivate)
@end
/////

typedef NSMutableSet<__kindof ARListViewItem *> * REUSED_SET;

@interface ARListView ()

@end

@implementation ARListView {
    ARListViewLayout *_layout;
    BOOL _hasAutoReload;
    NSMutableDictionary<NSIndexPath *,ARListViewLayoutItemAttributes *> *_itemsAttributes;
    NSMutableDictionary<NSString *,REUSED_SET> *_itemReusedPool;
    NSMapTable<NSIndexPath *,ARListViewItem *> *_visibleItems;
}
@dynamic delegate;
@synthesize layout = _layout;

- (instancetype)initWithLayout:(ARListViewLayout *)layout {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _layout = layout;
        [layout setListView:self];
        [self __setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    ARListViewFlowLayout *flowLayout = [[ARListViewFlowLayout alloc] init];
    return [self initWithLayout:flowLayout];
}

- (void)__setUp {
    _itemsAttributes = [NSMutableDictionary dictionary];
    _itemReusedPool = [NSMutableDictionary dictionary];
    _visibleItems = [NSMapTable strongToWeakObjectsMapTable];
    CFRunLoopRef runloop = CFRunLoopGetMain();
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                       kCFRunLoopBeforeWaiting | kCFRunLoopExit,
                                       true,      // repeat
                                       0xFFFFFF,  // after CATransaction(2000000)
                                       __RunLoopObserverCallBack, &context);
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

- (void)reloadData {
    NSUInteger sections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInListView:)]) {
        sections = [self.dataSource numberOfSectionsInListView:self];
    }
    CGFloat minX = 0.0;
    CGFloat maxX = 0.0;
    CGFloat minY = 0.0;
    CGFloat maxY = 0.0;
    CGFloat totalWidth = self.contentInset.left + self.contentInset.right;
    CGFloat totalHeight = self.contentInset.top + self.contentInset.bottom;
    for (NSUInteger i = 0; i < sections; i++) {
        NSUInteger numberOfItems = [self.dataSource listView:self numberOfItemsInSection:i];
        for (NSUInteger j = 0; j < numberOfItems; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            ARListViewLayoutItemAttributes *attributes = [self.layout attributesAtIndexPath:indexPath];
            [_itemsAttributes setObject:attributes forKey:indexPath];
            //
            CGRect itemFrame = attributes.frame;
            //
            minX = MIN(minX, CGRectGetMinX(itemFrame));
            maxX = MAX(maxX, CGRectGetMaxX(itemFrame));
            minY = MIN(minY, CGRectGetMinY(itemFrame));
            maxY = MAX(maxY, CGRectGetMaxY(itemFrame));
            //
            [self __showItemIfNeededWithIndexPath:indexPath attribute:attributes];
        }
    }
    totalWidth = totalWidth + (maxX - minX);
    totalHeight = totalHeight + (maxY - minY);
    self.contentSize = CGSizeMake(totalWidth, totalHeight);
}

- (REUSED_SET)__reusedSetForIdentifier:(NSString *)identifier {
    REUSED_SET set = _itemReusedPool[identifier];
    if (set == nil) {
        set = [NSMutableSet set];
        _itemReusedPool[identifier] = set;
    }
    return set;
}

- (void)__didScroll {
    //remove
    NSMutableSet *removes = [NSMutableSet set];
    for (NSIndexPath *indexPath in _visibleItems.keyEnumerator) {
        __kindof ARListViewItem *item = [_visibleItems objectForKey:indexPath];
        if (CGRectIsNull(CGRectIntersection(item.frame, self.bounds))) {
            REUSED_SET reuseSet = [self __reusedSetForIdentifier:@"__test"];
            [reuseSet addObject:item];
            [item removeFromSuperview];
            [removes addObject:indexPath];
        }
    }
    for (NSIndexPath *indexPath in removes) {
        [_visibleItems removeObjectForKey:indexPath];
    }
    
    // add
    [_itemsAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * _Nonnull key, ARListViewLayoutItemAttributes * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![_visibleItems objectForKey:key]) {
            [self __showItemIfNeededWithIndexPath:key attribute:obj];
        }
    }];
}

#define __ARListScrollInsetThreshold -100.0

- (void)__showItemIfNeededWithIndexPath:(NSIndexPath *)indexPath attribute:(ARListViewLayoutItemAttributes *)attr {
    //
    if (!CGRectIsNull(CGRectIntersection(attr.frame, CGRectInset(self.bounds, __ARListScrollInsetThreshold, __ARListScrollInsetThreshold)))) {
        __kindof ARListViewItem *item = [self.dataSource listView:self itemAtIndexPath:indexPath];
        item.frame = attr.frame;
        [self addSubview:item];
        [_visibleItems setObject:item forKey:indexPath];
    }
}

static void __RunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    ARListView *listView = (__bridge ARListView *)info;
    if (!listView->_hasAutoReload) {
        [listView reloadData];
        listView->_hasAutoReload = YES;
    }
    [listView __didScroll];
}

@end
