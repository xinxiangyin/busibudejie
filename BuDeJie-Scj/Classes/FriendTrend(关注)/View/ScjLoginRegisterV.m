//
//  ScjLoginRegisterV.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/23.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjLoginRegisterV.h"

@interface ScjLoginRegisterV()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation ScjLoginRegisterV

+ (instancetype) loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype) registerView{
        return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImage *image = _loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [_loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
