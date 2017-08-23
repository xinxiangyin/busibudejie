//
//  UIImage+ScjImageOriginal.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/15.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "UIImage+ScjImageOriginal.h"

@implementation UIImage (ScjImageOriginal)

+ (UIImage *)imageOriginalNamed:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

+ (UIImage *)scj_circleImageWithNamed:(NSString *)name{
    return [[self imageNamed:name] scj_circleImage];
}

- (UIImage *)scj_circleImage{
    // 1.开启图形上下文
    // 比例因素:当前点与像素比例
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描述裁剪区域
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁剪区域;
//    [path addClip];
    // 4.画图片
//    [self drawAtPoint:CGPointZero];
    // 5.取出图片
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
//    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [path addClip];
    
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
