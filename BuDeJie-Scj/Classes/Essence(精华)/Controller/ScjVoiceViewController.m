//
//  ScjVoiceViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/9/11.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjVoiceViewController.h"

@interface ScjVoiceViewController ()

@end

@implementation ScjVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (ScjTopicType)type{
    return ScjTopicTypeVoice;
};

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
