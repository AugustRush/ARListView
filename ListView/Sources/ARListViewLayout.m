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

@implementation ARListViewLayout {
    __weak ARListView *_listView;
}
@synthesize listView = _listView;

- (ARListViewLayoutItemAttributes *)attributesAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(0, @"should be subclass override!");
    return nil;
}

- (void)setListView:(ARListView *)listView {
    _listView = listView;
}

@end
