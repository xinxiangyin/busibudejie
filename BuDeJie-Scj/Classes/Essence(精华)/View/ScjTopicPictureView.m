//
//  ScjTopicPictureView.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/23.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTopicPictureView.h"
#import "ScjTopic.h"
#import "ScjSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>



@interface ScjTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageV;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageV;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;

@end

@implementation ScjTopicPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 控制按钮内部的子控件对齐，不是用contentMode，是用以下2个属性
    //    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    // 控件按钮内部子控件之间的间距
    //    btn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    //    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
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
        
        if (!image) return;
        
        self.placeholderImageV.hidden = YES;
        
        if (topic.isBigImage) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = topic.height * imageW / topic.width;
            
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.imageV.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageV.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
    }];
    
    self.gifImageV.hidden = !topic.is_gif;
    
    if (topic.isBigImage) {
        self.seeBigPictureBtn.hidden = NO;
        self.imageV.contentMode = UIViewContentModeTop;
        self.imageV.clipsToBounds = YES;
    } else {
        self.seeBigPictureBtn.hidden = YES;
        self.imageV.contentMode = UIViewContentModeScaleToFill;
        self.imageV.clipsToBounds = NO;
    }
}
@end
