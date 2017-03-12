//
//  YogaListViewController.m
//  ListView
//
//  Created by AugustRush on 2017/3/12.
//  Copyright © 2017年 August. All rights reserved.
//

#import "YogaListViewController.h"
#import "ARListView.h"
#import "ListViewItem1.h"
#import "ListViewItem2.h"

@interface YogaListViewController ()<ARListViewDataSource,ARListViewYogaLayoutDelegate,ARListViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSString *> *feeds;

@end

@implementation YogaListViewController

- (void)loadView {
    ARListViewYogaLayout *yogaLayout = [[ARListViewYogaLayout alloc] initWithDelegate:self];
    ARListView *listView = [[ARListView alloc] initWithLayout:yogaLayout];
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
        item.titleLabel.adjustsFontSizeToFitWidth = YES;
        item.titleLabel.text = [NSString stringWithFormat:@"%@[%ld  %ld]",text,(long)indexPath.row,(long)indexPath.section];
        listViewItem = item;
    } else {
        ListViewItem2 *item = [listView dequeueReusableItemWithIdentifier:@"item2" indexPath:indexPath];
        item.titleLabel.adjustsFontSizeToFitWidth = YES;
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

#pragma mark - ARListViewYogaLayoutDelegate methods

- (void)yogaLayout:(ARListViewYogaLayout *)yogaLayout configurationWithLayout:(YGLayout *)layout {
    layout.maxWidth = 320;
    layout.flexDirection = YGFlexDirectionRow;
    layout.justifyContent = YGJustifyFlexStart;
    layout.alignContent = YGAlignFlexStart;
    layout.alignItems = YGAlignFlexStart;
    layout.flexWrap = YGWrapWrap;
}

- (CGSize)yogaLayout:(ARListViewYogaLayout *)yogaLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake( 60 , 40);
}

- (void)yogaLayout:(ARListViewYogaLayout *)yogaLayout configurationForItemAtIndexPath:(NSIndexPath *)indexPath itemLayout:(YGLayout *)layout {
    layout.marginTop = 10;
    layout.marginRight = 10;
}

@end
