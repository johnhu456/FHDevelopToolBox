//
//  FontDetailViewController.h
//  DevelopToolBox
//
//  Created by MADAO on 16/5/5.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontDetailViewController : UIViewController

@property (nonatomic, strong, readonly) NSString *fontName;

- (instancetype)initWithFontName:(NSString *)fontName;

@end
