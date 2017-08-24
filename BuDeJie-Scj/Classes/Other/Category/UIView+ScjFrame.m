//
//  UIView+ScjFrame.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/25.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "UIView+ScjFrame.h"

@implementation UIView (ScjFrame)

+ (instancetype)scj_viewFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)setScj_height:(CGFloat)scj_height
{
    CGRect rect = self.frame;
    rect.size.height = scj_height;
    self.frame = rect;
}

- (CGFloat)scj_height
{
    return self.frame.size.height;
}

- (CGFloat)scj_width
{
    return self.frame.size.width;
}
- (void)setScj_width:(CGFloat)scj_width
{
    CGRect rect = self.frame;
    rect.size.width = scj_width;
    self.frame = rect;
}

- (CGFloat)scj_x
{
    return self.frame.origin.x;
    
}

- (void)setScj_x:(CGFloat)scj_x
{
    CGRect rect = self.frame;
    rect.origin.x = scj_x;
    self.frame = rect;
}

- (void)setScj_y:(CGFloat)scj_y
{
    CGRect rect = self.frame;
    rect.origin.y = scj_y;
    self.frame = rect;
}

- (CGFloat)scj_y
{
    
    return self.frame.origin.y;
}

- (void)setScj_centerX:(CGFloat)scj_centerX
{
    CGPoint center = self.center;
    center.x = scj_centerX;
    self.center = center;
}

- (CGFloat)scj_centerX
{
    return self.center.x;
}

- (void)setScj_centerY:(CGFloat)scj_centerY
{
    CGPoint center = self.center;
    center.y = scj_centerY;
    self.center = center;
}

- (CGFloat)scj_centerY
{
    return self.center.y;
}


@end
