//
//  UIBarButtonItem+Extension.m
//  Shire
//
//  Created by 陈正星 on 15/11/16.
//  Copyright © 2015年 LLJZ. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置默认状态图片
    [btn setBackgroundImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    // 设置高亮状态图片
    [btn setBackgroundImage:[UIImage imageNamed:higImageName] forState:UIControlStateHighlighted];
    // 设置frame
    btn.frame = (CGRect){CGPointZero,btn.currentBackgroundImage.size};
    // 添加监听事件
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    // 返回item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
@end
