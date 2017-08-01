//
//  ScjTabBarViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/15.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTabBarViewController.h"
#import "ScjNewViewController.h"
#import "ScjEssenceViewController.h"
#import "ScjMeTableViewController.h"
#import "ScjPublishViewController.h"
#import "ScjFriendtrendViewController.h"
#import "UIImage+ScjImageOriginal.h"
#import "ScjTabBar.h"
#import "ScjNavViewController.h"

@interface ScjTabBarViewController ()

@end

@implementation ScjTabBarViewController

+ (void)load{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor   forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAllChildVC];
    [self setupAllTitleButton];
    [self setupTabBar];
    
}

- (void)setupAllChildVC{
    ScjNavViewController *nav = [[ScjNavViewController alloc] initWithRootViewController: [[ScjEssenceViewController alloc] init]];
    [self addChildViewController:nav];
    ScjNavViewController *nav2 = [[ScjNavViewController alloc] initWithRootViewController: [[ScjNewViewController alloc] init]];
    [self addChildViewController:nav2];
    
//    [self addChildViewController:[[ScjPublishViewController alloc] init]];
    
    ScjNavViewController *nav3 = [[ScjNavViewController alloc] initWithRootViewController: [[ScjFriendtrendViewController alloc] init]];
    [self addChildViewController:nav3];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ScjMeTableViewController" bundle:nil];
    ScjMeTableViewController *meVC = [storyboard instantiateInitialViewController];
    ScjNavViewController *nav4 = [[ScjNavViewController alloc] initWithRootViewController: meVC];
    [self addChildViewController:nav4];
}

- (void)setupAllTitleButton{
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageOriginalNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalNamed:@"tabBar_essence_click_icon"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageOriginalNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalNamed:@"tabBar_new_click_icon"];
    
//    ScjPublishViewController *publishVC = self.childViewControllers[2];
//    publishVC.tabBarItem.image = [UIImage imageOriginalNamed:@"tabBar_publish_icon"];
//    publishVC.tabBarItem.selectedImage = [UIImage imageOriginalNamed:@"tabBar_publish_click_icon"];
//    publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageOriginalNamed:@"tabBar_friendTrends_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalNamed:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我";
    nav3.tabBarItem.image = [UIImage imageOriginalNamed:@"tabBar_me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalNamed:@"tabBar_me_click_icon"];
    
}

- (void)setupTabBar{
    
    ScjTabBar *tabBar = [[ScjTabBar alloc] init];
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
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
