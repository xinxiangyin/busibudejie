//
//  ScjFastLoginV.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/25.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjFastLoginV.h"

@implementation ScjFastLoginV

+ (instancetype)loadFastLoginV{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
