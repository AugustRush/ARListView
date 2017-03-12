//
//  ARListViewYogaLayoutRootAttributes.h
//  ListView
//
//  Created by AugustRush on 2017/3/12.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ARListViewLayoutItemAttributes+Yoga.h"

@interface ARListViewYogaLayoutRootAttributes : ARListViewLayoutItemAttributes

- (void)addLeafAttributes:(ARListViewLayoutItemAttributes *)attr;
- (void)removeAllAttributes;

@end
