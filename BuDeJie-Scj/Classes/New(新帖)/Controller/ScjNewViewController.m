//
//  ScjNewViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/14.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjNewViewController.h"
#import "UIBarButtonItem+Scj__item.h"
#import "ScjSubTagViewController.h"

@interface ScjNewViewController ()

@end

@implementation ScjNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    [self setupNavBar];
}

- (void)setupNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"]  addTarget:self action:@selector(tagClick)];
    
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

- (void)tagClick{
    ScjSubTagViewController *tagVc = [[ScjSubTagViewController alloc] init];
    [self.navigationController pushViewController:tagVc animated:YES];
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
