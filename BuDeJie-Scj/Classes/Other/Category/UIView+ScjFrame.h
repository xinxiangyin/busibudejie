//
//  UIView+ScjFrame.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/25.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScjFrame)

+ (instancetype)scj_viewFromNib;

@property CGFloat scj_width;
@property CGFloat scj_height;
@property CGFloat scj_x;
@property CGFloat scj_y;
@property CGFloat scj_centerX;
@property CGFloat scj_centerY;


@end
