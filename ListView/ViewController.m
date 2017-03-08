//
//  ViewController.m
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARListView.h"
#import "ListViewItem1.h"
#import "ListViewItem2.h"

@interface ViewController ()<ARListViewDataSource,ARListViewFlowLayoutDelegate>

@end

@implementation ViewController

- (void)loadView {
    ARListViewFlowLayout *flowLayout = [[ARListViewFlowLayout alloc] initWithDelegate:self];
    ARListView *listView = [[ARListView alloc] initWithLayout:flowLayout];
    listView.backgroundColor = [UIColor purpleColor];
    listView.dataSource = self;
    [listView registerClass:[ListViewItem1 class] forCellReuseIdentifier:@"item1"];
    [listView registerClass:[ListViewItem2 class] forCellReuseIdentifier:@"item2"];
    self.view = listView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ARListViewDataSource methods

- (NSUInteger)numberOfSectionsInListView:(ARListView *)listView {
    return 1;
}

- (NSUInteger)listView:(ARListView *)listView numberOfItemsInSection:(NSUInteger)section {
    return 100;
}

- (ARListViewItem *)listView:(ARListView *)listView itemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = indexPath.section == 0 ? @"item1" : @"item2";
    ARListViewItem *listViewItem = [listView dequeueReusableItemWithIdentifier:identifier indexPath:indexPath];
    return listViewItem;
}

#pragma mark - ARListViewFlowLayoutDelegate methods

- (CGSize)flowLayout:(ARListViewFlowLayout *)flowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 100);
}

@end
