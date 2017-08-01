//
//  ScjFriendtrendViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/14.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjFriendtrendViewController.h"
#import "UIBarButtonItem+Scj__item.h"
#import "ScjLoginRegisterViewController.h"

@interface ScjFriendtrendViewController ()

@end

@implementation ScjFriendtrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor greenColor];
    [self setupNavBar];
}
- (IBAction)clickLoginRegister {
    ScjLoginRegisterViewController *loginRegister = [[ScjLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)setupNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"]  addTarget:self action:@selector(friendtrend)];
    
    
    self.navigationItem.title = @"我的关注";
    
}

- (void)friendtrend{
    
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
