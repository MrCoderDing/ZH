//
//  UITabBar+RedPoint.h
//  ZYNaNian
//
//  Created by HenryVarro on 16/7/21.
//  Copyright © 2016年 ZYNaNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (RedPoint)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
