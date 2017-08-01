//
//  ScjSquareCollectionViewCell.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/28.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjSquareCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "ScjSquareItem.h"

@interface ScjSquareCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@end

@implementation ScjSquareCollectionViewCell

- (void)setItem:(ScjSquareItem *)item{
    _item = item;
    self.nameL.text = item.name;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.icon]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
