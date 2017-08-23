//
//  ScjVoiceTableViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/5.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjVoiceTableViewController.h"

@interface ScjVoiceTableViewController ()

@end

@implementation ScjVoiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ScjRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(ScjNavMaxY + ScjTitlesViewH, 0, ScjTabBarH, 0);
    
    self.tableView.scrollsToTop = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnRepeatClick) name:ScjTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleViewBtnRepeatClick) name:ScjTitleButtonDidRepeatClickNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听

- (void)tabBarBtnRepeatClick{
    
    if (self.view.window == nil) return;
    
    if (self.tableView.scrollsToTop == NO) return;
    
    ScjLog(@"%@ - 刷新数据", self.class)
    
}

- (void)titleViewBtnRepeatClick{
    
    [self tabBarBtnRepeatClick];
    
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
}

@end
