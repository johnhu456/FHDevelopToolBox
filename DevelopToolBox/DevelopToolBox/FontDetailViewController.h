//
//  FontDetailViewController.h
//  DevelopToolBox
//
//  Created by MADAO on 16/5/5.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 字体细节改变代理
 */
@protocol FontDetailDelegate <NSObject>

/**
 字体大小改变代理

 @param size 字体大小
 */
- (void)fontSizeDidChanged:(NSUInteger)size;

@end

@interface FontDetailViewController : UIViewController

/**
 字体名称
 */
@property (nonatomic, strong, readonly) NSString *fontName;

/**
 文字名称
 */
@property (nonatomic, strong, readonly) NSString *textName;

@property (nonatomic, weak) id<FontDetailDelegate>delegate;

- (instancetype)initWithFontName:(NSString *)fontName textName:(NSString *)textName;

@end
