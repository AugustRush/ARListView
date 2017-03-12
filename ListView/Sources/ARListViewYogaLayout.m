//
//  ARListViewYogaLayout.m
//  ListView
//
//  Created by AugustRush on 2017/3/11.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewYogaLayout.h"

@implementation ARListViewYogaLayout {
    id<ARListViewYogaLayoutDelegate> _delegate;
}

- (instancetype)initWithDelegate:(id<ARListViewYogaLayoutDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)preparedLayout {

}

- (CGSize)listViewContentSize {
    return CGSizeZero;
}

- (ARListViewLayoutItemAttributes *)layoutAttributesAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)finishedLayout {

}

@end
