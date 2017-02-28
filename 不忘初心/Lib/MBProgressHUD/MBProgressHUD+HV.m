//
//  MBProgressHUD+HV.m
//  PhotoSafeCalculator
//
//  Created by HenryVarro on 16/10/30.
//  Copyright © 2016年 HenryVarro. All rights reserved.
//

#import "MBProgressHUD+HV.h"

@implementation MBProgressHUD (HV)

/**
 显示消息
 
 @param message 消息内容（可不填）
 */
+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [MBProgressHUD showMessage:message toView:nil];
}


/**
 显示消息
 
 @param message 消息内容
 @param view    显示视图
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //隐藏
    [MBProgressHUD hideHUDForView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}



/**
 显示消息标题+副标题
 
 @param message 消息内容
 @param detail  副标题
 @param view    显示视图
 */
+ (MBProgressHUD *)showMessage:(NSString *)message andDetailMsg:(NSString *)detail toView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //隐藏
    [MBProgressHUD hideHUDForView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.detailsLabel.text = detail;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

/**
 显示短消息
 
 @param message 消息内容
 */
+ (MBProgressHUD *)showShotMessage:(NSString *)message{
   return  [MBProgressHUD showShotMessage:message toView:nil];
}

/**
 显示短消息
 
 @param message 消息内容
 @param view    显示视图
 */
+ (MBProgressHUD *)showShotMessage:(NSString *)message toView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //隐藏
    [MBProgressHUD hideHUDForView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
    return hud;
}


/**
 显示进度条

 @param text 文字
 @param view 视图
 @return hud
 */
+ (MBProgressHUD *)annularDeterminateText:(NSString *)text toView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [MBProgressHUD hideHUDForView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = text;
    return hud;
}

/**
 隐藏hud
 
 @param view 显示视图
 */
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    [hud hideAnimated:YES];
}

/**
 快捷隐藏Hud
 */
+ (void)hideHUD{
    [MBProgressHUD hideHUDForView:nil];
}


/**
 显示完成
 
 @param message 消息内容
 */
+ (void)showCompleteMessage:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:1.5f];

}
@end
