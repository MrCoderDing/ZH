//
//  UIAlertView+Additions.h
//  testDemo
//
//  Created by HenryVarro on 16/4/18.
//  Copyright © 2016年 ZYNaNian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @brief UIAlertView扩展
 */
@interface UIAlertView (Additions)

/*!
 *  @brief  构造UIAlertView
 *
 *  @param title             标题
 *  @param message           内容
 *  @param buttonIndex       选中 block
 *  @param cancelButtonTitle 取消按钮
 *  @param otherButtonTitles 其他按钮
 *
 *  @return UIAlertView
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message  buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
