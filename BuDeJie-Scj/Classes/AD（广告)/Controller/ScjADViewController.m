//
//  ScjADViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/18.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "ScjAdItem.h"
#import "ScjTabBarViewController.h"

#define screenH [UIScreen mainScreen].bounds.size.height

@interface ScjADViewController ()

@property (weak, nonatomic) IBOutlet UIView *adContentV;

@property (weak, nonatomic) IBOutlet UIImageView *lauchImageV;

@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (nonatomic, weak) UIImageView *adImageV;

@property (nonatomic, strong) ScjAdItem *adItem;

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ScjADViewController

- (UIImageView *)adImageV{
    
    if (_adImageV == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.adContentV addSubview:imageV];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageV addGestureRecognizer:tap];
        imageV.userInteractionEnabled = YES;
        _adImageV = imageV;
    }
    
    return _adImageV;
}

- (void)tap{
    
    NSURL *url = [NSURL URLWithString:_adItem.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url options:@{} completionHandler:nil];
    }
    
}
- (IBAction)jump {
    
    ScjTabBarViewController *tabBarVC = [[ScjTabBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    
    [_timer invalidate];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupLauchImage];
    
    [self loadAdData];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}

- (void)timeChange{
    static int i = 3;
    
    if (i == 0) {
        [self jump];
    }
    i --;
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转(%d)",i] forState:UIControlStateNormal];
    
}


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
- (void)loadAdData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"code2"] = code2;
    
    
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/shicangjian/Desktop/OC项目/ad.plist" atomically:YES];
        NSDictionary *dict = [responseObject[@"ad"] lastObject];
        _adItem = [ScjAdItem mj_objectWithKeyValues:dict];
        CGFloat h =  [UIScreen mainScreen].bounds.size.width * _adItem.h / _adItem.w;
        self.adImageV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, h);
        [self.adImageV sd_setImageWithURL:[NSURL URLWithString:_adItem.w_picurl]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
        
        
    }];
    
    
}

- (void) setupLauchImage{
    // 6p:LaunchImage-800-Portrait-736h@3x.png
    // 6:LaunchImage-800-667h@2x.png
    // 5:LaunchImage-568h@2x.png
    // 4s:LaunchImage@2x.png
    if (screenH == 736) { // 6p
        self.lauchImageV.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (screenH == 667) { // 6
        self.lauchImageV.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (screenH == 568) { // 5
        self.lauchImageV.image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    } else if (screenH == 480) { // 4
        
        self.lauchImageV.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
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
