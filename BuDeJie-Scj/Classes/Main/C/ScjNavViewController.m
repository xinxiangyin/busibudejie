//
//  ScjNavViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/17.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjNavViewController.h"
#import "UIBarButtonItem+Scj__item.h"

@interface ScjNavViewController () <UIGestureRecognizerDelegate>

@end

@implementation ScjNavViewController

+ (void)load{
    UINavigationBar * navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[ScjNavViewController class]]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    navBar.titleTextAttributes = dict;
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
//    self.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    return self.childViewControllers.count > 1;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //多次使用的方法，用方法参数
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithNormalImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(back) title:@"返回"];
//        NSLog(@"%@",self.interactivePopGestureRecognizer);
//        <UIScreenEdgePanGestureRecognizer: 0x7fbe93e17d00; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fbe96300850>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fbe93e172f0>)>>

    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
    
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
