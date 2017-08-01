//
//  ScjLoginRegisterViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/23.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjLoginRegisterViewController.h"
#import "ScjLoginRegisterV.h"
#import "ScjFastLoginV.h"

@interface ScjLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet ScjLoginRegisterV *midV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingCons;
@property (weak, nonatomic) IBOutlet ScjFastLoginV *botV;

@end

@implementation ScjLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ScjLoginRegisterV *loginV = [ScjLoginRegisterV loginView];
    [_midV addSubview:loginV];
    ScjLoginRegisterV *registerV = [ScjLoginRegisterV registerView];
    [_midV addSubview:registerV];
    
    ScjFastLoginV *fastLoginV = [ScjFastLoginV loadFastLoginV];
    [_botV addSubview:fastLoginV];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews{
    ScjLoginRegisterV *loginV = _midV.subviews[0];
    loginV.frame = CGRectMake(0, 0, _midV.bounds.size.width * 0.5, _midV.bounds.size.height);
    ScjLoginRegisterV *registerV = _midV.subviews[1];
    registerV.frame = CGRectMake(_midV.bounds.size.width * 0.5, 0, _midV.bounds.size.width * 0.5, _midV.bounds.size.height);
    ScjFastLoginV *fastLoginV = _botV.subviews.firstObject;
    fastLoginV.frame = _botV.bounds;
    
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegist:(UIButton *)sender {
    sender.selected = !sender.selected;
    _leadingCons.constant = _leadingCons.constant == 0 ? -_midV.bounds.size.width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
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
