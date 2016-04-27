//
//  FHClearMenuController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHClearMenuController.h"
#import "FHSideMenuController.h"


static NSString *const cellReuseIdentifier = @"CellReuseIdentifier";

@interface FHClearMenuController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainMenuTableView;

@end

@implementation FHClearMenuController

#pragma mark - Public Method
- (void)setBackgroundColor:(UIColor *)color
{
    if (self.mainMenuTableView){
        self.mainMenuTableView.backgroundColor = color;
    }
}

- (void)setBackgroundImage:(UIImage *)image withContentMode:(UIViewContentMode)mode
{
    if (self.mainMenuTableView) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
        backgroundImageView.contentMode = mode;
        backgroundImageView.frame = self.mainMenuTableView.frame;
        [self.mainMenuTableView setBackgroundView:backgroundImageView];
    }
}

#pragma mark - Privare Method
- (instancetype)initWithMenuTitleArray:(NSArray *)titleArray
{
    if (self = [super init]) {
        _titleArray = titleArray;
        [self setupmainMenuTableView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupmainMenuTableView{
    self.mainMenuTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mainMenuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainMenuTableView.dataSource = self;
    self.mainMenuTableView.delegate = self;
    [self.view addSubview:self.mainMenuTableView];
    self.view.frame = self.view.frame;
}

#pragma mark - UITableViewDataSourceAndDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *menuCell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (menuCell == nil) {
        menuCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        menuCell.backgroundColor = [UIColor clearColor];
    }
    id titleObj = _titleArray[indexPath.row];
    NSAssert([titleObj isKindOfClass:[NSString class]], @"The object in titleArrat must be  NSString type");
    menuCell.textLabel.text = (NSString *)titleObj;

    return menuCell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FHSideMenuController *sideMenuController = (FHSideMenuController *)self.parentViewController;
#warning to change CenterMenuController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
