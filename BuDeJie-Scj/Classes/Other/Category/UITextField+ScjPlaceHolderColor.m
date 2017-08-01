//
//  UITextField+ScjPlaceHolderColor.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/25.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "UITextField+ScjPlaceHolderColor.h"
#import <objc/message.h>

@implementation UITextField (ScjPlaceHolderColor)

+ (void)load{
    Method method1 = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method method2 = class_getInstanceMethod(self, @selector(setScj_placeholder:));
    method_exchangeImplementations(method1, method2);
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    objc_setAssociatedObject(self, @"placeHolderColor", placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeHolder = [self valueForKey:@"placeholderLabel"];
    placeHolder.textColor = placeHolderColor;
    
}

- (UIColor *)placeHolderColor{
    return objc_getAssociatedObject(self, @"OBJC_ASSOCIATION_RETAIN_NONATOMIC");
}

- (void)setScj_placeholder:(NSString *)placeholder{
    
    [self setScj_placeholder:placeholder];
    self.placeHolderColor = self.placeHolderColor;
    
}

@end
