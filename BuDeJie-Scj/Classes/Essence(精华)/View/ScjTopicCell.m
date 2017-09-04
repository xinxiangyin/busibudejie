//
//  ScjTopicCell.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/19.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTopicCell.h"
#import "ScjTopic.h"
#import "ScjTopicVideoView.h"
#import "ScjTopicVoiceView.h"
#import "ScjTopicPictureView.h"
#import <UIImageView+WebCache.h>

@interface ScjTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCmtV;
@property (weak, nonatomic) IBOutlet UILabel *top_cmtL;

/* 中间控件 */
@property (nonatomic, weak) ScjTopicVideoView *videoV;

@property (nonatomic, weak) ScjTopicVoiceView *voiceV;

@property (nonatomic, weak) ScjTopicPictureView *pictureV;

@end

@implementation ScjTopicCell

#pragma mark - 懒加载
- (ScjTopicVideoView *)videoV{
    if (!_videoV) {
        ScjTopicVideoView *videoV = [ScjTopicVideoView scj_viewFromNib];
        [self.contentView addSubview:videoV];
        _videoV = videoV;
    }
    return _videoV;
}

- (ScjTopicVoiceView *)voiceV{
    if (!_voiceV) {
        ScjTopicVoiceView *voiceV = [ScjTopicVoiceView scj_viewFromNib];
        [self.contentView addSubview:voiceV];
        _voiceV = voiceV;
    }
    return _voiceV;
}
- (ScjTopicPictureView *)pictureV{
    if (!_pictureV) {
        ScjTopicPictureView *pictureV = [ScjTopicPictureView scj_viewFromNib];
        [self.contentView addSubview:pictureV];
        _pictureV = pictureV;
    }
    return _pictureV;
}

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(ScjTopic *)topic{
    _topic = topic;
    
    [self.profileImageView scj_setHeader:topic.profile_image];
        
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    // 不能用以下条件来判断数组里面是否有存放元素
    //    if (topic.top_cmt) {
    //
    //    }
    //    if (topic.top_cmt != nil) {
    //
    //    }
    
    //    NSString *str = @"";
    //    if (str)
    //    if (str.length)

    if (topic.top_cmt.count) {
        self.topCmtV.hidden = NO;
        
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *topCmt = cmt[@"content"];
        if (topCmt.length == 0) {
            topCmt = @"[语音评论]";//搞错了self.top_cmtL.text = @"[语音评论]";
        }
        NSString *userName = cmt[@"user"][@"username"];
        
        self.top_cmtL.text = [NSString stringWithFormat:@"%@ : %@",userName,topCmt];
    }else{
        self.topCmtV.hidden = YES;
    }
    
    [self setBtnTitel:self.dingButton withNumber:topic.ding placeholder:@"顶"];
    [self setBtnTitel:self.caiButton withNumber:topic.ding placeholder:@"踩"];
    [self setBtnTitel:self.repostButton withNumber:topic.ding placeholder:@"分享"];
    [self setBtnTitel:self.commentButton withNumber:topic.ding placeholder:@"评论"];
    
    if (topic.type == ScjTopicTypeVideo) {
        self.videoV.topic = topic;
        self.videoV.hidden = NO;
        self.voiceV.hidden = YES;
        self.pictureV.hidden = YES;
    } else if(topic.type == ScjTopicTypeVoice){
        self.voiceV.topic = topic;
        self.videoV.hidden = YES;
        self.voiceV.hidden = NO;
        self.pictureV.hidden = YES;
    } else if(topic.type == ScjTopicTypePicture){
        self.pictureV.topic = topic;
        self.videoV.hidden = YES;
        self.voiceV.hidden = YES;
        self.pictureV.hidden = NO;
    } else if(topic.type == ScjTopicTypeWord){
        self.videoV.hidden = YES;
        self.voiceV.hidden = YES;
        self.pictureV.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.topic.type == ScjTopicTypeVideo) {
        self.videoV.frame = self.topic.middleFrame;
    } else if (self.topic.type == ScjTopicTypeVoice) {
        self.voiceV.frame = self.topic.middleFrame;
    } else if (self.topic.type == ScjTopicTypePicture) {
        self.pictureV.frame = self.topic.middleFrame;
    }
}

- (void)setBtnTitel:(UIButton *)Btn withNumber:(NSInteger)number placeholder:(NSString *)placeholder{
    if (number >= 10000) {
        [Btn setTitle:[NSString stringWithFormat:@"%0.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [Btn setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [Btn setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= ScjMargin;
    
    [super setFrame:frame];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
