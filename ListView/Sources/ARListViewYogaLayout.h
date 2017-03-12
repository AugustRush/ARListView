//
//  ARListViewYogaLayout.h
//  ListView
//
//  Created by AugustRush on 2017/3/11.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayout.h"

@class ARListViewYogaLayout;
@protocol ARListViewYogaLayoutDelegate <NSObject>

@required
- (CGSize)flowLayout:(ARListViewYogaLayout *)flowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ARListViewYogaLayout : ARListViewLayout

- (instancetype)initWithDelegate:(id<ARListViewYogaLayoutDelegate>)delegate;

@end
