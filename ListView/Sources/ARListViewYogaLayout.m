//
//  ARListViewYogaLayout.m
//  ListView
//
//  Created by AugustRush on 2017/3/11.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewYogaLayout.h"
#import "ARListView.h"
#import "ARListViewLayout+Private.h"
#import "ARListViewLayoutItemAttributes.h"
#import "YGLayout.h"
#import "YGLayout+Private.h"

@implementation ARListViewYogaLayout {
    id<ARListViewYogaLayoutDelegate> _delegate;
    ARListViewYogaLayoutRootAttributes *_rootLayoutAttributes;
}

- (instancetype)initWithDelegate:(id<ARListViewYogaLayoutDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _rootLayoutAttributes = [[ARListViewYogaLayoutRootAttributes alloc] init];
    }
    return self;
}

- (void)preparedLayout {
    [_rootLayoutAttributes removeAllAttributes];
    _rootLayoutAttributes.yoga.isEnabled = YES;
}

- (CGSize)listViewContentSize {
    _rootLayoutAttributes.frame = self.listView.bounds;
    //
    NSUInteger sections = [self.listView numberOfSections];
    for (NSUInteger i = 0; i < sections; i++) {
        NSUInteger numberOfItems = [self.listView numberOfItemsInSection:i];
        for (NSUInteger j = 0; j < numberOfItems; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            ARListViewLayoutItemAttributes *attributes = [[ARListViewLayoutItemAttributes alloc] init];
            YGLayout *itemLayout = attributes.yoga;
            itemLayout.isEnabled = YES;
            [_delegate yogaLayout:self configurationForItemAtIndexPath:indexPath itemLayout:itemLayout];
            [self __cachedAttributes:attributes atIndexPath:indexPath];
            //
            [_rootLayoutAttributes addLeafAttributes:attributes];
            //
        }
    }
    [_delegate yogaLayout:self configurationWithLayout:_rootLayoutAttributes.yoga];
    [_rootLayoutAttributes.yoga applyLayoutWithSize:CGSizeMake(NAN, NAN) preserveOrigin:YES];
    return CGSizeMake(_rootLayoutAttributes.frame.size.width, _rootLayoutAttributes.frame.size.height);
}

- (ARListViewLayoutItemAttributes *)layoutAttributesAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self __getCachedAttributesAtIndexPath:indexPath];
}

- (void)finishedLayout {
    [_rootLayoutAttributes removeAllAttributes];
}

@end
