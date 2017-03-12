//
//  YogaLayoutable.h
//  YogaDemo
//
//  Created by AugustRush on 2017/3/12.
//  Copyright © 2017年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YGLayout;
@protocol YogaLayoutable <NSObject>

@property (nonatomic, readonly, strong) YGLayout *yoga;
@property (nonatomic) CGRect frame;
@property (nonatomic, readonly, assign) BOOL isLeaf;
@property (nonatomic, assign) BOOL isEnableLayout;
@property (nonatomic, readonly) NSArray<id<YogaLayoutable>> *leafNodes;

@end
