//
//  SideMenuViewController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHSideMenuController.h"
#import "FHTool.h"
#import "UIView+Frame.h"

static 

@interface FHSideMenuController ()

@end


@implementation FHSideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self setupUIGestureRecognizer];
    
}

- (void)setupUIGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    CGFloat windowWidth = [FHTool getCurrentWindow].frame.size.width;
    _leftViewController = leftViewController;
    [self addChildViewController:_leftViewController];
    [self.view addSubview:_leftViewController.view];
    CGPoint leftViewControllerOrigin = CGPointMake(- windowWidth, 0);
    _leftViewController.view.frame = (CGRect){leftViewControllerOrigin,[FHTool getCurrentWindow].frame.size};
    
}

- (void)setCenterViewController:(UIViewController *)centerViewController
{
    _centerViewController = centerViewController;
    [self addChildViewController:_centerViewController];
    [self.view addSubview:_centerViewController.view];
    _centerViewController.view.frame = self.view.frame;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GestureMethod

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGes
{
    CGPoint transition = [panGes translationInView:self.view];
    _centerViewController.view.x += transition.x;
    _leftViewController.view.x += transition.x;
    [panGes setTranslation:CGPointZero inView:self.view];
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
