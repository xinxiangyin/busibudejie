//
//  ScjEssenceViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/14.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjEssenceViewController.h"
#import "UIBarButtonItem+Scj__item.h"

@interface ScjEssenceViewController ()

@end

@implementation ScjEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
}

- (void)setupNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"]  addTarget:self action:@selector(game)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:nil action:nil];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}



- (void)game{
    
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
