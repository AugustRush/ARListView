/**
 * Copyright (c) 2014-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "UIView+Yoga.h"
#import "YGLayout+Private.h"
#import <objc/runtime.h>

static const void *kYGYogaAssociatedKey = &kYGYogaAssociatedKey;

@implementation UIView (YogaKit)

- (YGLayout *)yoga
{
  YGLayout *yoga = objc_getAssociatedObject(self, kYGYogaAssociatedKey);
  if (!yoga) {
    yoga = [[YGLayout alloc] initWithView:self];
    objc_setAssociatedObject(self, kYGYogaAssociatedKey, yoga, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }

  return yoga;
}

- (void)configureLayoutWithBlock:(YGLayoutConfigurationBlock)block
{
  if (block != nil) {
    block(self.yoga);
  }
}

- (BOOL)isLeaf
{
    NSAssert([NSThread isMainThread], @"This method must be called on the main thread.");
    if (self.yoga.isEnabled) {
        for (UIView *subview in self.subviews) {
            YGLayout *const yoga = subview.yoga;
            if (yoga.isEnabled && yoga.isIncludedInLayout) {
                return NO;
            }
        }
    }
    
    return YES;
}

- (NSArray<id<YogaLayoutable>> *)leafNodes {
    return self.subviews;
}

@end
