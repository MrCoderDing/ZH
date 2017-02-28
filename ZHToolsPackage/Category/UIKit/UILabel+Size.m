//
//  UILabel+Size.m
//  ZYNaNian
//
//  Created by HenryVarro on 16/9/20.
//  Copyright © 2016年 ZYNaNian. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)


- (CGSize)labelSize
{
    return [self sizeWithText:self.text font:self.font maxWidth:MAXFLOAT];
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxWidth:MAXFLOAT];
}
/// 根据指定文本,字体和最大宽度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}
@end
