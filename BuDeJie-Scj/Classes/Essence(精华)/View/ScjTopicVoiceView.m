//
//  ScjTopicVoiceView.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/23.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTopicVoiceView.h"
#import "ScjTopic.h"
#import "ScjSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface ScjTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *playCountL;

@property (weak, nonatomic) IBOutlet UILabel *voiceTimeL;

@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageV;
@end

@implementation ScjTopicVoiceView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageV.userInteractionEnabled = YES;
    [self.imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

- (void)seeBigPicture{
    
    ScjSeeBigPictureViewController *vc = [[ScjSeeBigPictureViewController alloc] init];
    
    vc.topic = self.topic;
    
    //    [UIApplication sharedApplication].keyWindow.rootViewController;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
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
    self.voiceTimeL.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}



@end
