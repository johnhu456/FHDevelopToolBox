//
//  SideMenuViewController.h
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHSideMenuController : UIViewController

@property (nonatomic, assign) CGFloat maxSideWidth;

@property (nonatomic, assign) CGFloat animationDuration;

/**可以选择使用FHClearMenuController或者自定义一个*/
@property (nonatomic, weak) UIViewController *leftViewController;

@property (nonatomic, weak) UIViewController *centerViewController;

- (void)handlePushNewCenterViewController:(UIViewController *)newController;
@end
