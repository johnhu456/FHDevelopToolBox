//
//  FontViewController.h
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontViewController : UITableViewController
//字体大小 默认为20
@property (nonatomic, assign) CGFloat size;
/**示例文字*/
@property (nonatomic, strong) NSString *sampleText;

@end
