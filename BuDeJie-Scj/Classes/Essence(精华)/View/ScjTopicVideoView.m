//
//  ScjTopicVideoView.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/23.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTopicVideoView.h"
#import "ScjTopic.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface ScjTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *playCountL;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeL;

@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageV;
@end

@implementation ScjTopicVideoView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(ScjTopic *)topic
{
    _topic = topic;
    self.placeholderImageV.hidden = NO;
    [self.imageV scj_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            self.placeholderImageV.hidden = YES;
        }
    }];
    
    // 播放数量
    if (topic.playcount >= 10000) {
        self.playCountL.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
    } else {
        self.playCountL.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    // %04d : 占据4位，多余的空位用0填补
    self.videoTimeL.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}


@end
