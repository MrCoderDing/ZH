//
//  UILabel+Size.h
//  ZYNaNian
//
//  Created by HenryVarro on 16/9/20.
//  Copyright © 2016年 ZYNaNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Size)

/**
 *  根据字体返回size
 *
 *  @return 字体size
 */
- (CGSize)labelSize;

/**
 *  Label Size
 *
 *  @param text 文本内容
 *  @param font 字体
 *
 *  @return size
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;

/**
 *  Label Size
 *
 *  @param text  文本
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return size
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width;
@end
