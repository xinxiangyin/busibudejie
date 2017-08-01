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

@end
