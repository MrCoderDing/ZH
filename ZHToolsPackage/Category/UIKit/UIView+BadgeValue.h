//
//  UIView+BadgeValue.h
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BadgeValue)

/**
 设置角标值，nil隐藏，0红点，其他显示字符串
 
 @param badgeValue 角标值
 */
-(void)setBadgeValue:(NSString *)badgeValue;

/**
 设置角标视图的frame
 
 @param frame frame
 */
-(void)setBadgeViewFrame:(CGRect)frame;

/**
 设置视图的背景颜色
 
 @param bgColor 颜色
 */
-(void)setBadgeViewColor:(UIColor *)bgColor;

/**
 设置角标值得颜色
 
 @param bgColor 颜色
 */
-(void)setBadgeTextColor:(UIColor *)textColor;

/**
 设置字体大小
 
 @param textFont 字体
 */
-(void)setBadgeTextFont:(UIFont *)textFont;

/**
 设置圆角大小
 
 @param cornerRadius 圆角大小
 */
-(void)setBadgeViewCornerRadius:(CGFloat)cornerRadius;

@end
