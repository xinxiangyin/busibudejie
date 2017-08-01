//
//  ScjMeTableViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/14.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjMeTableViewController.h"
#import "UIBarButtonItem+Scj__item.h"
#import "ScjSettingTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "ScjSquareItem.h"
#import "ScjSquareCollectionViewCell.h"
#import "UIView+ScjFrame.h"
#import <SafariServices/SafariServices.h>


@interface ScjMeTableViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *squareItems;

@property (nonatomic, weak) UICollectionView *collectionV;

@end


static NSString *const ID = @"Cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH  ([UIScreen mainScreen].bounds.size.width - (cols - 1) * margin) / cols
@implementation ScjMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor blueColor];
    
    [self setupNavBar];
    
    [self setUpFootView];
    
    [self loadData];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);//35-10, 64-25
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));//{64, 0, 49, 0}
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@",NSStringFromCGRect(cell.frame));//{{0, 35}, {375, 44}}
//}

- (void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/shicangjian/Desktop/OC项目/SquareItem.plist" atomically:YES];
        NSArray *dictArr = responseObject[@"square_list"];
        _squareItems = [ScjSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        [self resloveData];
        
        NSInteger count = _squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        _collectionV.scj_height = rows * itemWH + 10;//计算高度有偏差，特意加了10
        
        self.tableView.tableFooterView = _collectionV;
        
        [_collectionV reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)resloveData{
    NSInteger count = _squareItems.count;
    NSInteger exter = cols - count % cols;
    if (exter < cols) {
        for (int i = 0; i < exter; i ++) {
            [_squareItems addObject:[[ScjSquareItem alloc] init]];
        }
    }
    
}

- (void)setUpFootView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectiongV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectiongV.scrollEnabled = NO;
    _collectionV = collectiongV;
    collectiongV.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = collectiongV;
    //数据源方法调用，需要设置调用对象
    collectiongV.dataSource = self;
    collectiongV.delegate = self;
    
    [collectiongV registerNib:[UINib nibWithNibName:@"ScjSquareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ScjSquareItem *item = _squareItems[indexPath.row];
    
    if (![item.url containsString:@"http"]) return;
        
    NSURL *url = [NSURL URLWithString:item.url];
    SFSafariViewController *safriVC = [[SFSafariViewController alloc] initWithURL:url];
//    safriVC.delegate = self;
    [self presentViewController:safriVC animated:YES completion:nil];//SFSafariViewController调用modal方法,自动调用dismissed方法
}
#pragma mark - SFSafariViewControllerDelegate
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//    [self popoverPresentationController];
//}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScjSquareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = _squareItems[indexPath.item];
    
    return cell;
}

- (void)setupNavBar{
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"]  addTarget:self action:@selector(setting)];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    
    self.navigationItem.title = @"我的";
    
}

- (void)setting{
    ScjSettingTableViewController *settingVC = [[ScjSettingTableViewController alloc] init];
//    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (void)night:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

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
