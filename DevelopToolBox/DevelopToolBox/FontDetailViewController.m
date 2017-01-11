//
//  FontDetailViewController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/5/5.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FontDetailViewController.h"

@interface FontDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *lblExample;

@property (weak, nonatomic) IBOutlet UILabel *lblSize;
@property (weak, nonatomic) IBOutlet UISlider *sldSize;
@property (nonatomic, strong, readwrite) NSString *fontName;
/**
 文字名称
 */
@property (nonatomic, strong, readwrite) NSString *textName;
@end

@implementation FontDetailViewController

- (void)setFontName:(NSString *)fontName
{
    _fontName = fontName;
    self.title = fontName;
}

- (instancetype)initWithFontName:(NSString *)fontName textName:(NSString *)textName
{
    if (self = [super init])
    {
        self.fontName = fontName;
        self.textName = textName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblExample.text = self.textName;
    self.lblExample.font = [UIFont fontWithName:self.fontName size:self.sldSize.value];
    self.lblSize.text = [NSString stringWithFormat:@"当前字体大小：%d",(int)self.sldSize.value];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 滚动条Value改变
 */
- (IBAction)silderDidChanged:(UISlider *)sender {
    sender.value = (int)sender.value;
    //字体改变
    self.lblExample.font = [UIFont fontWithName:self.fontName size:sender.value];
    self.lblSize.text = [NSString stringWithFormat:@"当前字体大小：%d",(int)self.sldSize.value];
    //通知代理
    if ([self.delegate respondsToSelector:@selector(fontSizeDidChanged:)]) {
        [self.delegate fontSizeDidChanged:sender.value];
    }
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
