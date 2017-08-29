//
//  UIImageView+download.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/29.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "UIImageView+download.h"
//#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@implementation UIImageView (download)

- (void)scj_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock{
    
    // 占位图片
//    UIImage *placeholder = nil;
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    if (originImage) { // 原图已经被下载过
        self.image = originImage;
        
        completedBlock(originImage, nil, 0, [NSURL URLWithString:originImageURL]);
    } else { // 原图并未下载过
        if (mgr.isReachableViaWiFi) {
//            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                
//            }];
            
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
        } else if (mgr.isReachableViaWWAN) {
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            }
        } else { // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { // 缩略图已经被下载过
                self.image = thumbnailImage;
                
                completedBlock(thumbnailImage, nil, 0, [NSURL URLWithString:thumbnailImageURL]);
            } else { // 没有下载过任何图片
                // 占位图片;
                self.image = placeholder;
            }
        }
    }
    
}

- (void)scj_setHeader:(NSString *)headerURL{
    
    UIImage *placeholder = [UIImage scj_circleImageWithNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:headerURL] placeholderImage:placeholder options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        self.image = [image scj_circleImage];
    }];
    
}

@end
