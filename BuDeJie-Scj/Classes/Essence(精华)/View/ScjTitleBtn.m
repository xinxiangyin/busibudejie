//
//  ScjTitleBtn.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/4.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTitleBtn.h"

@implementation ScjTitleBtn

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    };
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{// 只要重写了这个方法，按钮就无法进入highlighted状态
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
