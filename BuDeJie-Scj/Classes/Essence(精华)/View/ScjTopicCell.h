//
//  ScjTopicCell.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/19.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ScjTopic.h"

@class ScjTopic;//不用方法，声明类即可
@interface ScjTopicCell : UITableViewCell

@property(nonatomic, strong) ScjTopic *topic;

@end
