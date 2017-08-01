//
//  UIBarButtonItem+Scj__item.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/17.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "UIBarButtonItem+Scj__item.h"

@implementation UIBarButtonItem (Scj__item)

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

+ (UIBarButtonItem *)backItemWithNormalImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

@end
