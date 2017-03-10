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

@interface ViewController ()<ARListViewDataSource,ARListViewFlowLayoutDelegate,ARListViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSString *> *feeds;

@end

@implementation ViewController

- (void)loadView {
    ARListViewFlowLayout *flowLayout = [[ARListViewFlowLayout alloc] initWithDelegate:self];
    ARListView *listView = [[ARListView alloc] initWithLayout:flowLayout];
    listView.backgroundColor = [UIColor purpleColor];
    listView.dataSource = self;
    listView.delegate = self;
    [listView registerClass:[ListViewItem1 class] forCellReuseIdentifier:@"item1"];
    [listView registerClass:[ListViewItem2 class] forCellReuseIdentifier:@"item2"];
    self.view = listView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.feeds = [NSMutableArray array];
    for (int i = 0; i < 200; i++) {
        [self.feeds addObject:@"Test"];
    }
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
    return self.feeds.count;
}

- (ARListViewItem *)listView:(ARListView *)listView itemAtIndexPath:(NSIndexPath *)indexPath {
    ARListViewItem *listViewItem;
    NSString *text = self.feeds[indexPath.row];
    
    if (indexPath.section == 0) {
        ListViewItem1 *item = [listView dequeueReusableItemWithIdentifier:@"item1" indexPath:indexPath];
        item.titleLabel.text = [NSString stringWithFormat:@"%@[%ld  %ld]",text,(long)indexPath.row,(long)indexPath.section];
        listViewItem = item;
    } else {
        ListViewItem2 *item = [listView dequeueReusableItemWithIdentifier:@"item2" indexPath:indexPath];
        item.titleLabel.text = [NSString stringWithFormat:@"%@[%ld  %ld]",text,(long)indexPath.row,(long)indexPath.section];
        listViewItem = item;
    }
    return listViewItem;
}

#pragma mark - ARListViewDelegate methods

- (void)listView:(ARListView *)listView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did selected row at %@",indexPath);
    NSIndexPath *insert = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [self.feeds insertObject:@"INSERT" atIndex:indexPath.row];
    [listView insertItemsAtIndexPaths:@[insert]];
}

#pragma mark - ARListViewFlowLayoutDelegate methods

- (CGSize)flowLayout:(ARListViewFlowLayout *)flowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(300, 40 + indexPath.row);
}

@end
