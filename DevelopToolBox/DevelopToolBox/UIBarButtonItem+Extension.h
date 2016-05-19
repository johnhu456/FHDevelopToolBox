//
//  UIBarButtonItem+Extension.h
//  Shire
//
//  Created by 陈正星 on 15/11/16.
//  Copyright © 2015年 LLJZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action;
@end
