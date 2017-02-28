//
//  MBProgressHUD+HV.h
//  PhotoSafeCalculator
//
//  Created by HenryVarro on 16/10/30.
//  Copyright © 2016年 HenryVarro. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HV)



/**
 显示消息

 @param message 消息内容（可不填）
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;


/**
 显示消息

 @param message 消息内容
 @param view    显示视图
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;



/**
 显示消息标题+副标题

 @param message 消息内容
 @param detail  副标题
 @param view    显示视图
 */
+ (MBProgressHUD *)showMessage:(NSString *)message andDetailMsg:(NSString *)detail toView:(UIView *)view;


/**
 显示短消息

 @param message 消息内容
 */
+ (MBProgressHUD *)showShotMessage:(NSString *)message;

/**
 显示短消息

 @param message 消息内容
 @param view    显示视图
 */
+ (MBProgressHUD *)showShotMessage:(NSString *)message toView:(UIView *)view;


/**
 显示圆形进度条

 @param text 进度条内容
 @param view 显示视图
 @return hud
 */
+ (MBProgressHUD *)annularDeterminateText:(NSString *)text toView:(UIView *)view;



/**
 隐藏hud

 @param view 显示视图
 */
+ (void)hideHUDForView:(UIView *)view;

/**
 快捷隐藏Hud
 */
+ (void)hideHUD;


/**
 显示完成

 @param message 消息内容
 */
+ (void)showCompleteMessage:(NSString *)message;
@end
