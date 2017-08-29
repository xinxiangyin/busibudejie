//
//  UIImageView+download.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/29.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (download)

- (void)scj_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock;

- (void)scj_setHeader:(NSString *)headerURL;

@end
