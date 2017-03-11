//
//  ARListViewLayoutItemAttribute.h
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ARListViewLayoutItemAttributes : NSObject

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGFloat zIndex;
@property (nonatomic, getter=isHidden) BOOL hidden; // As an optimization, ARListView might not create a view for items whose hidden attribute is YES

@end
