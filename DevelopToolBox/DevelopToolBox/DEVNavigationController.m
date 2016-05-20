//
//  DEVNavigationController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/5/20.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "DEVNavigationController.h"
#import "FHTool.h"

@interface DEVNavigationController ()

@end

@implementation DEVNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = FH_COLOR_WITH(0x27, 0x26, 0x36, 1);
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:30]};
    [self.navigationItem.rightBarButtonItem setWidth:30];
}

- (void)handleLeftBarbuttonItemOnClicked:(UIBarButtonItem *)item
{
    NSLog(@"sdad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
