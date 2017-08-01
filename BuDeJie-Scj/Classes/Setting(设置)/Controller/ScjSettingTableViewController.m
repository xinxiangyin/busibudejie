//
//  ScjSettingTableViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/17.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjSettingTableViewController.h"
#import "ScjToolFile.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDImageCache.h>//模仿这个[SDImageCache sharedImageCache].getSize;

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface ScjSettingTableViewController ()

@property(nonatomic, assign) NSInteger totalSize;

@end

static NSString *const ID = @"cell";
@implementation ScjSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [SVProgressHUD showWithStatus:@"正在计算内存……"];
    
    [ScjToolFile getFileSizeWithDirectoryPath:CachePath completion:^(NSInteger totalSize) {
        _totalSize = totalSize;
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];
    
}

- (void)jump{
    UIViewController * vc = [[UIViewController alloc] init];
    
    vc.view.backgroundColor = [UIColor redColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [self sizeStr];
    
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ScjToolFile removeDirectoryPath:CachePath];
    
    _totalSize = 0;
    
    [self.tableView reloadData];
}

- (NSString *)sizeStr{
    
    NSInteger totalSize = _totalSize;
    
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;
    
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
