//
//  FontViewController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FontViewController.h"
#import "FHTool.h"

@interface FontViewController ()<UITableViewDelegate,UITableViewDataSource>

#warning may need to change
@property (nonatomic, strong) NSArray *fontFamilyArray;

@property (nonatomic, strong) NSArray *fontArray;

@property (nonatomic, strong) NSArray *firstCharacterArray;

/**记录字母索引对应Section的关系*/
@property (nonatomic, strong) NSDictionary *titleToIndexDictionary;

@property (nonatomic, strong) UITableView *mainFontTableView;


@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"All Font";
    [self setupMainTableView];
    [self getAscendFontArray];
    [self getFirstCharacterArray];
}

- (void)setupMainTableView
{
    self.mainFontTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.mainFontTableView.delegate = self;
    self.mainFontTableView.dataSource = self;
    [self.view addSubview:self.mainFontTableView];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainCell"];
    }
    NSArray *aFamily = self.fontArray[indexPath.section];
    cell.textLabel.text = aFamily[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:aFamily[indexPath.row] size:20];
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{
    return self.firstCharacterArray;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
    return [[self.titleToIndexDictionary objectForKey:title] integerValue];
    
}
//
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return [NSString stringWithFormat:@"%ld",(long)section];
//    NSArray *arrayOfCharacters = [self sectionIndexTitlesForTableView:self.mainFontTableView];
//    return [self.characterArray objectAtIndex:section];
    
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
