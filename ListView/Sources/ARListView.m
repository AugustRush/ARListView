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

#define DEBUG_LOG 0

#if DEBUG_LOG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

@interface _ARListItemReusedInfo : NSObject

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) ARListViewLayoutItemAttributes *attribute;
@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, strong) __kindof ARListViewItem *item;

@end

@implementation _ARListItemReusedInfo

@end

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
    NSHashTable<__kindof ARListViewItem *> *_visibleItems;
    NSMapTable<NSIndexPath *,_ARListItemReusedInfo *> *_visibleItemInfos;
    NSMutableDictionary<NSString *, Class> *_registedItemClasses;
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
    _visibleItems = [NSHashTable weakObjectsHashTable];
    _visibleItemInfos = [NSMapTable strongToStrongObjectsMapTable];
    _registedItemClasses = [NSMutableDictionary dictionary];
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

#pragma mark - Public methods

- (void)reloadData {
    [_layout preparedLayout];
    [_visibleItems removeAllObjects];
    [_visibleItemInfos removeAllObjects];
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
            ARListViewLayoutItemAttributes *attributes = [_layout layoutAttributesAtIndexPath:indexPath];
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
    [_layout finishedLayout];
}

- (void)registerClass:(Class)itemClass forCellReuseIdentifier:(NSString *)identifier {
    [_registedItemClasses setObject:itemClass forKey:identifier];
}

- (ARListViewLayoutItemAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_layout layoutAttributesAtIndexPath:indexPath];
}

- (ARListViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {

    Class itemClass = [_registedItemClasses objectForKey:identifier];
    REUSED_SET reuseSet = [self __reusedSetForIdentifier:identifier];
    __kindof ARListViewItem *item = [reuseSet anyObject];
    if (item == nil) {
        item = [[itemClass alloc] init];
    } else {
        [reuseSet removeObject:item];
    }
    [self __setVisibleItem:item forIdentifier:identifier indexPath:indexPath];
    return item;
}

#pragma mark - Private methods

- (void)__setVisibleItem:(__kindof ARListViewItem *)item forIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    [_visibleItems addObject:item];
    _ARListItemReusedInfo *info = [[_ARListItemReusedInfo alloc] init];
    info.reuseIdentifier = identifier;
    info.attribute = _itemsAttributes[indexPath];
    info.indexPath = indexPath;
    info.item = item;
    [_visibleItemInfos setObject:info forKey:indexPath];
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
    [CATransaction begin];
    //remove
    NSMutableSet *removes = [NSMutableSet set];
    for (NSIndexPath *indexPath in _visibleItemInfos.keyEnumerator) {
        _ARListItemReusedInfo *info = [_visibleItemInfos objectForKey:indexPath];
        if (![self __selfBoundsIsContainedFrame:info.item.frame]) {
            REUSED_SET reuseSet = [self __reusedSetForIdentifier:info.reuseIdentifier];
            [reuseSet addObject:info.item];
            [info.item removeFromSuperview];
            [_visibleItems removeObject:info.item];
            //
            [removes addObject:indexPath];
        }
    }
    // remove infos
    for (NSIndexPath *indexPath in removes) {
        NSLog(@"REmove ----> %ld %ld",[indexPath section],[indexPath row]);
        [_visibleItemInfos removeObjectForKey:indexPath];
    }
    // add
    [_itemsAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * _Nonnull key, ARListViewLayoutItemAttributes * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([_visibleItemInfos objectForKey:key] == nil) {// hasn't visible
            [self __showItemIfNeededWithIndexPath:key attribute:obj];
        }
    }];
    //
    [CATransaction commit];
}

- (void)__showItemIfNeededWithIndexPath:(NSIndexPath *)indexPath attribute:(ARListViewLayoutItemAttributes *)attr {
    //
    if ([self __selfBoundsIsContainedFrame:attr.frame]) {
        __kindof ARListViewItem *item = [self.dataSource listView:self itemAtIndexPath:indexPath];
        item.frame = attr.frame;
        [self addSubview:item];
        NSLog(@"add ----> [%ld  %ld]",indexPath.section,indexPath.row);
    }
}

#define __ARListScrollInsetThreshold -100.0

- (BOOL)__selfBoundsIsContainedFrame:(CGRect)frame {
    CGRect thresholdRect = CGRectInset(self.bounds, __ARListScrollInsetThreshold, __ARListScrollInsetThreshold);
    return CGRectIntersectsRect(thresholdRect, frame);
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
