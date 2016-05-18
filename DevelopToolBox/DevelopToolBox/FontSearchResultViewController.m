//
//  FontSearchResultViewController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/5/18.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FontSearchResultViewController.h"
#import "FontDetailViewController.h"

@interface FontSearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *searchResultTableView;

@end

@implementation FontSearchResultViewController

- (void)setResultDataArray:(NSArray *)resultDataArray
{
    _resultDataArray = resultDataArray;
    [self.searchResultTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchResultTableView];
}

- (void)setupSearchResultTableView{
    self.searchResultTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.searchResultTableView.dataSource = self;
    self.searchResultTableView.delegate = self;
    [self.view addSubview:self.searchResultTableView];
}

#pragma mark - UITableViewDelegateAndDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mainCell"];
    }
    cell.textLabel.text = self.resultDataArray[indexPath.row];
    return  cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fontName = self.resultDataArray[indexPath.row];
    FontDetailViewController *detailViewController = [[FontDetailViewController alloc] initWithFontName:fontName];
    [self.mainViewController.navigationController pushViewController:detailViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
