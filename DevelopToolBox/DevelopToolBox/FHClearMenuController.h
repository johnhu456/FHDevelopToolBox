//
//  FHClearMenuController.h
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHClearMenuController : UIViewController

@property (nonatomic, strong) NSArray *titleArray;

- (instancetype)initWithMenuTitleArray:(NSArray *)titleArray;

- (void)setBackgroundColor:(UIColor *)color;

- (void)setBackgroundImage:(UIImage *)image withContentMode:(UIViewContentMode)mode;

@end
