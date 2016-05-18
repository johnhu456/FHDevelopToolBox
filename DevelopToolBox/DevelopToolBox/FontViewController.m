//
//  FontViewController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FontViewController.h"
#import "FHTool.h"
#import "FontSearchResultViewController.h"

static CGFloat const kCellHeight = 60.f;

@interface FontViewController ()<UISearchResultsUpdating,UISearchBarDelegate>

/**搜索结果ViewController*/
@property (nonatomic, strong) FontSearchResultViewController *searchResultViewController;

@property (nonatomic, strong) UISearchController *searchViewController;

@property (nonatomic, strong) NSArray *fontFamilyArray;

@property (nonatomic, strong) NSArray *fontArray;

@property (nonatomic, strong) NSArray *firstCharacterArray;

/**记录字母索引对应Section的关系*/
@property (nonatomic, strong) NSDictionary *titleToIndexDictionary;

//@property (nonatomic, strong) UITableView *tableView

/**示例文字*/
@property (nonatomic, strong) NSString *sampleText;


//==========AboutSearch==================
@property (nonatomic, strong) NSArray *searchedFamilyArray;

@property (nonatomic, strong) NSArray *searchedFontArray;

@end

@implementation FontViewController

- (void)setSampleText:(NSString *)sampleText
{
    _sampleText = sampleText;
    if (self.tableView) {
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"All Font";
    self.sampleText = @"SampleText";
    
    [self setupSearchController];
//    [self setupMainTableView];
    [self getAscendFontArray];
    [self getFirstCharacterArray];
    [self setupRightNavigationBarButton];
}

- (void)setupSearchController
{
    self.searchResultViewController = [[FontSearchResultViewController alloc] init];
    self.searchViewController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultViewController];
    [self.searchViewController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
    self.searchViewController.searchResultsUpdater = self;
    self.searchViewController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
}

//- (void)setupMainTableView
//{
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [FHTool getWindowHeight], 44)];
//    searchBar.delegate = self;
//    self.tableView.tableHeaderView = searchBar;
//}

- (void)getAscendFontArray
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    NSArray *familyArray= [UIFont familyNames];
    self.fontFamilyArray = [FHTool sortUsingDescriptorDictionary:@{[NSNull null]:@YES} withArray:familyArray];
    for (NSString *familyName in self.fontFamilyArray) {
        NSArray *aFamily = [UIFont fontNamesForFamilyName:familyName];
        NSArray *aFamilySortedArray = [FHTool sortUsingDescriptorDictionary:@{[NSNull null]:@YES} withArray:aFamily];
        if (!aFamilySortedArray.count) {
            aFamilySortedArray = @[familyName];
        }
        [resultArray addObject:aFamilySortedArray];
    }
    self.fontArray = resultArray;
}

- (void)getFirstCharacterArray{
    NSMutableDictionary *mutaTitleToIndexDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *firstCharacterArray = [[NSMutableArray alloc] init];
    NSInteger sectionCount = 0;
    for (NSString *familyName in self.fontFamilyArray ) {
        unichar firstCharacterChar = [familyName characterAtIndex:0];
        NSString *firstCharacterStr = [NSString stringWithFormat:@"%c",firstCharacterChar];
        //防止重复character的插入
        if (![firstCharacterStr isEqualToString:[firstCharacterArray lastObject]]) {
            [firstCharacterArray addObject:firstCharacterStr];
            [mutaTitleToIndexDictionary setObject:[NSNumber numberWithInteger:sectionCount] forKey:firstCharacterStr];
        }
        sectionCount++;
    }
    self.firstCharacterArray = [firstCharacterArray copy];
    self.titleToIndexDictionary = mutaTitleToIndexDictionary;

}

- (void)setupRightNavigationBarButton
{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"更改文字" style:UIBarButtonItemStyleDone target:self action:@selector(handleChangeTextButtonOnClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
#pragma mark - UITableViewDataSourceAndDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fontArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *aFamily = self.fontArray[section];
    return aFamily.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mainCell"];
    }
    NSArray *aFamily = self.fontArray[indexPath.section];
    cell.textLabel.text = self.sampleText;
    cell.detailTextLabel.text = aFamily[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:aFamily[indexPath.row] size:20];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.firstCharacterArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[self.titleToIndexDictionary objectForKey:title] integerValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.fontFamilyArray[section];
}

#pragma mark - ACtions
- (void)handleChangeTextButtonOnClicked
{
    @WEAKSELF;
    UIAlertController *changeTextAlertController = [UIAlertController alertControllerWithTitle:@"更改示例文字" message:@"请输入您想要更改的示例文字" preferredStyle:UIAlertControllerStyleAlert];

    __block UITextField *sampleTextField = [[UITextField alloc] init];
    [changeTextAlertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        sampleTextField = textField;
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.sampleText = sampleTextField.text;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [changeTextAlertController addAction:confirmAction];
    [changeTextAlertController addAction:cancelAction];
    [self presentViewController:changeTextAlertController animated:YES completion:nil];
}

#pragma mark - UISearchResultUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSMutableArray *searchResultArray = [[NSMutableArray alloc] init];
    NSString *searchString = searchController.searchBar.text;
    for (NSArray *family in self.fontArray) {
        for (NSString *fontName in family) {
            NSRange resultRange = [fontName rangeOfString:searchString];
            if (resultRange.length > 0){
                [searchResultArray addObject:fontName];
            }
        }
    }
    self.searchResultViewController.resultDataArray = searchResultArray;
}
@end
