//
//  ScjTopicVoiceView.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/23.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTopicVoiceView.h"
#import "ScjTopic.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface ScjTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *playCountL;

@property (weak, nonatomic) IBOutlet UILabel *voiceTimeL;

@end

@implementation ScjTopicVoiceView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(ScjTopic *)topic
{
    _topic = topic;
    
    // 占位图片
    UIImage *placeholder = nil;
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
    if (originImage) { // 原图已经被下载过
        self.imageV.image = originImage;
    } else { // 原图并未下载过
        if (mgr.isReachableViaWiFi) {
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
        } else if (mgr.isReachableViaWWAN) {
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self.imageV sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
            } else {
                [self.imageV sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholder];
            }
        } else { // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
            if (thumbnailImage) { // 缩略图已经被下载过
                self.imageV.image = thumbnailImage;
            } else { // 没有下载过任何图片
                // 占位图片;
                self.imageV.image = placeholder;
            }
        }
    }
    
    // 播放数量
    if (topic.playcount >= 10000) {
        self.playCountL.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
    } else {
        self.playCountL.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    // %04d : 占据4位，多余的空位用0填补
    self.voiceTimeL.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}



@end
