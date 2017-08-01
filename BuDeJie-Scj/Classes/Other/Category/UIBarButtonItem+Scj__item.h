//
//  UIBarButtonItem+Scj__item.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/17.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Scj__item)

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithNormalImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action title:(NSString *)title;

@end
