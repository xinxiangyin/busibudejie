//
//  ScjFastLoginBtn.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/25.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjFastLoginBtn.h"
#import "UIView+ScjFrame.h"

@implementation ScjFastLoginBtn

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //三部曲的方式，不知道为什么出错了
//    CGRect frame = self.imageView.frame;
//    frame.origin.y = 0;
//    self.imageView.frame = frame;
//    
//    CGPoint center = self.imageView.center;
//    center.x = self.bounds.size.width * 0.5;
//    self.imageView.center = center;
//    
//    CGRect titleFrame = self.titleLabel.frame;
//    titleFrame.origin.y = self.imageView.frame.size.height;
//    self.imageView.frame = titleFrame;
//    
//    [self.titleLabel sizeToFit];
//    CGPoint titleCenter = self.titleLabel.center;
//    titleCenter.x = self.bounds.size.width * 0.5;
//    self.imageView.center = titleCenter;
    
    self.imageView.scj_y = 0;
    self.imageView.scj_centerX = self.bounds.size.width * 0.5;
    
    self.titleLabel.scj_y = self.imageView.scj_height;
    // 计算文字宽度 , 设置label的宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.scj_centerX = self.bounds.size.width * 0.5;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
