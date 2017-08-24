//
//  ScjTopic.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/9.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 帖子的类型 1为全部 10为图片 29为段子 31为音频 41为视频 */
typedef NS_ENUM(NSInteger, ScjTopicType){
    ScjTopicTypeAll = 1,//注意这里，是逗号，不是分号
    ScjTopicTypeVideo = 41,
    ScjTopicTypeVoice = 31,
    ScjTopicTypePicture = 10,
    ScjTopicTypeWord = 29
};


@interface ScjTopic : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;
/** 宽度(像素) */
@property (nonatomic, assign) NSInteger width;
/** 高度(像素) */
@property (nonatomic, assign) NSInteger height;

/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;

/* 额外增加的属性（并非服务器返回的属性，仅仅是为了提高开发效率） */
/** 根据当前模型计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleFrame;

@end
