//
//  RootViewController.m
//  ListView
//
//  Created by AugustRush on 2017/3/11.
//  Copyright © 2017年 August. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "UIView+Yoga.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.justifyContent = YGJustifyCenter;
    }];
    
    for (UIView *sub in self.view.subviews) {
        sub.yoga.isEnabled = YES;
    }
    
    [self.view.yoga applyLayoutWithSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 400) preserveOrigin:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushTableList:(id)sender {
    ViewController *tableList = [[ViewController alloc] init];
    [self.navigationController pushViewController:tableList animated:YES];
}

- (IBAction)pushYogaList:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
