//
//  ScjAdItem.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/22.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScjAdItem : NSObject

/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@end
