//
//  ScjLoginRegisterTF.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/25.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjLoginRegisterTF.h"
#import "UITextField+ScjPlaceHolderColor.h"

@implementation ScjLoginRegisterTF

- (void)awakeFromNib{
    [super awakeFromNib];
    //光标颜色
    self.tintColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(editingBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(editingEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
//    UITextField *text; ==> _placeholderLabel
    
    self.placeHolderColor = [UIColor grayColor];
}

- (void)editingBegin{
    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.placeHolderColor = [UIColor whiteColor];
}

- (void)editingEnd{
    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.placeHolderColor = [UIColor grayColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
