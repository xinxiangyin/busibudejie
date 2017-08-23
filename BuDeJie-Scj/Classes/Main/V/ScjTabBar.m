//
//  ScjTabBar.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/17.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTabBar.h"

@interface ScjTabBar()

@property (nonatomic ,weak) UIButton *plusBtn;

@property (nonatomic, weak) UIControl *preClickedTabBarBtn;

@end

@implementation ScjTabBar

- (UIButton *)plusBtn{
    if (_plusBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        
        _plusBtn = btn;
    }
    return _plusBtn;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    CGFloat barBtnW = self.bounds.size.width / (count + 1);
    CGFloat barBtnH = self.bounds.size.height;
    CGFloat x = 0;
    int i = 0;
    
    for (UIControl *barBtn in self.subviews) {
        if ([barBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 0 && self.preClickedTabBarBtn == nil) {
                self.preClickedTabBarBtn = barBtn;
            }
            
            if (i == 2) {
                i++;
            }
            x = i * barBtnW;
            barBtn.frame = CGRectMake(x, 0, barBtnW, barBtnH);
            i++;
            
            [barBtn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        self.plusBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    }
    
}

- (void)tabBarBtnClick:(UIControl *)tabBarBtn{
    
    if (self.preClickedTabBarBtn == tabBarBtn) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ScjTabBarButtonDidRepeatClickNotification object:nil];
        
    }
    
    self.preClickedTabBarBtn = tabBarBtn;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
