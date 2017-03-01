//
//  UIView+Extension.h
//  ZYNaNian
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 ZYNaNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat maxX;

/**
 绘制圆角
 
 @param rectCorner rectCorner
 */
- (void)cornerRectWith:(UIRectCorner)rectCorner;

/**
 视图快照

 @return 快照图片
 */
- (UIImage *)snapshoot;
@end
