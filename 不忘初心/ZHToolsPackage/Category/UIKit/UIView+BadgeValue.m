//
//  UIView+BadgeValue.m
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import "UIView+BadgeValue.h"
#import <objc/runtime.h>

#ifndef kBadgeValueView
#define kBadgeValueView @"__BadgeValueView__"
#endif

static CGFloat kBadgeViewHeight =15.0f;

@implementation UIView (BadgeValue)

-(UIButton *)badgeButton{
    
    return objc_getAssociatedObject(self, kBadgeValueView);
}

-(void)setBadgeButton:(UIButton *)btn{
    
    objc_setAssociatedObject(self, kBadgeValueView, btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setBadgeValue:(NSString *)badgeValue
{
    if (!self.badgeButton) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        btn.backgroundColor =[UIColor colorWithRed:0.933 green:0.114 blue:0.153 alpha:1.000];
        self.badgeButton =btn;
    }
    if (![self.badgeButton isDescendantOfView:self]) {
        [self addSubview:self.badgeButton];
    }
    if (badgeValue==nil) {
        //隐藏
        [self.badgeButton setHidden:YES];
    }
    else{
        [self.badgeButton setHidden:NO];
        if ([@"0" isEqualToString:badgeValue]) {
            //显示圆点
            self.badgeButton.layer.cornerRadius =5.0f;
            self.badgeButton.frame =CGRectMake(0, 0, 10, 10);
            self.badgeButton.center =CGPointMake(CGRectGetWidth(self.frame), 0);
            [self.badgeButton setTitle:@"" forState:UIControlStateNormal];
        }else{
            //显示内容
            CGSize btnSize =CGSizeZero;
            UILabel *textLabel =[self.badgeButton titleLabel];
            if ([[UIDevice currentDevice] systemVersion].floatValue >=7.0) {
                btnSize =[badgeValue  boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textLabel.font} context:nil].size;
            }else{
                btnSize =[badgeValue sizeWithFont:textLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 15) lineBreakMode:NSLineBreakByWordWrapping];
            }
            self.badgeButton.layer.cornerRadius =kBadgeViewHeight/2;
            self.badgeButton.frame =CGRectMake(0, 0, btnSize.width>kBadgeViewHeight?btnSize.width+6:kBadgeViewHeight, kBadgeViewHeight);
            self.badgeButton.center =CGPointMake(CGRectGetWidth(self.frame), 0);
            [self.badgeButton setTitle:badgeValue forState:UIControlStateNormal];
        }
        [self bringSubviewToFront:self.badgeButton];
    }
}
-(void)setBadgeViewFrame:(CGRect)frame{
    
    self.badgeButton.frame =frame;
}

-(void)setBadgeViewColor:(UIColor *)bgColor{
    
    [self.badgeButton setBackgroundColor:bgColor];
}

-(void)setBadgeTextColor:(UIColor *)textColor{
    
    [self.badgeButton setTitleColor:textColor forState:UIControlStateNormal];
}

-(void)setBadgeTextFont:(UIFont *)textFont{
    
    [self.badgeButton.titleLabel setFont:textFont];
    [self setBadgeValue:self.badgeButton.titleLabel.text];
}


-(void)setBadgeViewCornerRadius:(CGFloat)cornerRadius{
    
    [self.badgeButton.layer setCornerRadius:cornerRadius];
}

@end
