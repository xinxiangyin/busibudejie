//
//  UIImage+ScjImageOriginal.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/15.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScjImageOriginal)

+ (UIImage *)imageOriginalNamed:(NSString *)name;

+ (UIImage *)scj_circleImageWithNamed:(NSString *)name;

- (UIImage *)scj_circleImage;

@end
