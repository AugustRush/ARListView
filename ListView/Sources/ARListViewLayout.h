//
//  ARListViewLayout.h
//  ListView
//
//  Created by AugustRush on 2017/3/8.
//  Copyright © 2017年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ARListView;
@class ARListViewLayoutItemAttributes;
@interface ARListViewLayout : NSObject

@property (nonatomic, readonly) ARListView *listView;
// subclass should override methods
- (ARListViewLayoutItemAttributes *)attributesAtIndexPath:(NSIndexPath *)indexPath;

@end
