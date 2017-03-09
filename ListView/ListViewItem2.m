//
//  ListViewItem2.m
//  ListView
//
//  Created by AugustRush on 2017/3/8.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ListViewItem2.h"

@implementation ListViewItem2

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)setUp {
    self.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:30];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

@end
