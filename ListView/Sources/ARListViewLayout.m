//
//  ARListViewLayout.m
//  ListView
//
//  Created by AugustRush on 2017/3/8.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayout.h"
#import "ARListViewLayoutItemAttributes.h"
#import "ARListView.h"

#define ARListViewInvalidAttributes @0

@implementation ARListViewLayout {
    __weak ARListView *_listView;
    NSMutableArray<NSMutableArray *> *_itemsAttributes;
}
@synthesize listView = _listView;

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemsAttributes = [NSMutableArray array];
    }
    return self;
}

#pragma mark - subclass override methods

- (ARListViewLayoutItemAttributes *)layoutAttributesAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(0, @"should be subclass override!");
    return nil;
}

- (NSArray<ARListViewLayoutItemAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attrs = [NSMutableArray array];
    for (NSUInteger i = 0; i < _itemsAttributes.count; i++) {
        NSMutableArray *array = _itemsAttributes[i];
        for (NSUInteger j = 0; j < array.count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            ARListViewLayoutItemAttributes *attr = [self __getCachedAttributesAtIndexPath:indexPath];
            if (attr == nil) {
                attr = [self layoutAttributesAtIndexPath:indexPath];
                [self __cachedAttributes:attr atIndexPath:indexPath];
            }
            if (CGRectIntersectsRect(rect, attr.frame)) {
                [attrs addObject:attr];   
            }
        }
    }

    return attrs;
}

- (void)preparedLayout {
    NSAssert(0, @"should be subclass override!");
}

- (void)finishedLayout {
    NSAssert(0, @"should be subclass override!");
}

- (void)setListView:(ARListView *)listView {
    _listView = listView;
}

#pragma mark - Private methods

#pragma mark - cached attributes handle methods

- (NSMutableArray *)__attributesCachedArrayForSection:(NSUInteger)section {
    if (section >= _itemsAttributes.count) {
        for (NSUInteger i = _itemsAttributes.count; i <= section; i++) {
            [_itemsAttributes addObject:[NSMutableArray array]];
        }
    }
    return _itemsAttributes[section];
}

- (void)__cachedAttributes:(ARListViewLayoutItemAttributes *)attributes atIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *cachedArray = [self __attributesCachedArrayForSection:indexPath.section];
    if (indexPath.row >= cachedArray.count) {
        for (NSUInteger i = cachedArray.count; i <= indexPath.row; i++) {
            [cachedArray addObject:ARListViewInvalidAttributes];
        }
    }
    attributes.indexPath = indexPath;
    [cachedArray replaceObjectAtIndex:indexPath.row withObject:attributes];
}

- (nullable ARListViewLayoutItemAttributes *)__getCachedAttributesAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *cachedArray = [self __attributesCachedArrayForSection:indexPath.section];
    if (indexPath.row < cachedArray.count) {
        return cachedArray[indexPath.row];
    }
    return nil;
}

@end
