//
//  ViewController.m
//  ListView
//
//  Created by AugustRush on 2017/3/7.
//  Copyright © 2017年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARListView.h"

@interface ViewController ()<ARListViewDataSource,ARListViewFlowLayoutDelegate>

@end

@implementation ViewController

- (void)loadView {
    ARListViewFlowLayout *flowLayout = [[ARListViewFlowLayout alloc] initWithDelegate:self];
    ARListView *listView = [[ARListView alloc] initWithLayout:flowLayout];
    listView.backgroundColor = [UIColor purpleColor];
    listView.dataSource = self;
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
    return 2;
}

- (NSUInteger)listView:(ARListView *)listView numberOfItemsInSection:(NSUInteger)section {
    return 10;
}

- (ARListViewItem *)listView:(ARListView *)listView itemAtIndexPath:(NSIndexPath *)indexPath {
    ARListViewItem *listViewItem = [[ARListViewItem alloc] init];
    listViewItem.backgroundColor = [UIColor whiteColor];
    return listViewItem;
}

#pragma mark - ARListViewFlowLayoutDelegate methods

- (CGSize)flowLayout:(ARListViewFlowLayout *)flowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 100);
}

@end
