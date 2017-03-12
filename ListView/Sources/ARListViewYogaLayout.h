//
//  ARListViewYogaLayout.h
//  ListView
//
//  Created by AugustRush on 2017/3/11.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayout.h"
#import "ARListViewYogaLayoutRootAttributes.h"
#import "YGLayout.h"

@class ARListViewYogaLayout;
@protocol ARListViewYogaLayoutDelegate <NSObject>

@required
- (void)yogaLayout:(ARListViewYogaLayout *)yogaLayout configurationWithLayout:(YGLayout *)layout;

- (void)yogaLayout:(ARListViewYogaLayout *)yogaLayout configurationForItemAtIndexPath:(NSIndexPath *)indexPath itemLayout:(YGLayout *)layout;

@end

@interface ARListViewYogaLayout : ARListViewLayout

- (instancetype)initWithDelegate:(id<ARListViewYogaLayoutDelegate>)delegate;

@end
