//
//  ScjSubTagTableViewCell.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/23.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjSubTagTableViewCell.h"
#import "ScjTagItem.h"
#import <UIImageView+WebCache.h>

@interface ScjSubTagTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconV;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *numL;

@end

@implementation ScjSubTagTableViewCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;

    [super setFrame:frame];
}

- (void)setItem:(ScjTagItem *)item{
    
    _nameL.text = item.theme_name;
//    NSString *str = item.sub_number;
//    self.numL.text = [NSString stringWithFormat:@"%@人订阅",str];
//    if (str.integerValue > 10000) {
//        CGFloat numF = str.integerValue / 10000.0;
//        self.numL.text = [NSString stringWithFormat:@"%.1f万人订阅",numF];
//    }
    NSString *numStr = [NSString stringWithFormat:@"%@人定义",item.sub_number];
    NSInteger num = item.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;//注意加.0
        numStr = [NSString stringWithFormat:@"%.1f万人定义",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numL.text = numStr;
    
//    [_iconV sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [_iconV scj_setHeader:item.image_list];
}


//- (void)awakeFromNib {
//    [super awakeFromNib];
//    //ios9之后
//    _iconV.layer.cornerRadius = 30;
//    _iconV.layer.masksToBounds = YES;
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
