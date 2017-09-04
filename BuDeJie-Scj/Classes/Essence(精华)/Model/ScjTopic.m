//
//  ScjTopic.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/9.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjTopic.h"

@implementation ScjTopic

- (CGFloat)cellHeight{
    // 这2个方法只适合计算单行文字的宽高
    //    [topic.text sizeWithFont:[UIFont systemFontOfSize:15]].width;
    //    [UIFont systemFontOfSize:15].lineHeight;
    
    if (_cellHeight) return _cellHeight;
    
    _cellHeight += 55;
    
    CGSize textMaxSize = CGSizeMake(ScjScreeenW - 2 * ScjMargin, MAXFLOAT);
    
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height + ScjMargin;
    
    if (self.type != ScjTopicTypeWord) {
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH > ScjScreeenH) {
            middleH = 200;
            self.bigImage = YES;
        }
        CGFloat middleY = _cellHeight;
        CGFloat middleX = ScjMargin;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        
        _cellHeight += middleH + ScjMargin;
    }
    
    if (self.top_cmt.count) {
        _cellHeight += 18;
        
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *userName = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@",userName,content];
        
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height + ScjMargin;
        
    }
    
    _cellHeight += 35 +  ScjMargin;
    
    return _cellHeight;
}

@end
