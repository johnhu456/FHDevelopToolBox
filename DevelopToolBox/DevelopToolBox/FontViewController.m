//
//  FontViewController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FontViewController.h"
#import "FontSearchResultViewController.h"
#import "FontDetailViewController.h"

#import "FHTool.h"
#import "UIBarButtonItem+Extension.h"

static CGFloat const kCellHeight = 90.f;

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
    self.searchResultViewController.mainSearchController = self;
    self.definesPresentationContext = YES;
}

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
    UIBarButtonItem *leftBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_leftNavi_menu"] style:UIBarButtonItemStyleDone target:self action:@selector(handleLeftBarbuttonItemOnClicked:)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftBarbuttonItem;
//    [self.navigationItem.leftBarButtonItem setWidth:30];
    
    UIBarButtonItem *rightBarEditItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_rightNavi_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(handleChangeTextButtonOnClicked)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarEditItem;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray *aFamily = self.fontArray[indexPath.section];
    NSString *fontName = aFamily[indexPath.row];
    FontDetailViewController *detailViewController = [[FontDetailViewController alloc] initWithFontName:fontName];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
#pragma mark - ACtions
- (void)handleLeftBarbuttonItemOnClicked
{
    
}
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
