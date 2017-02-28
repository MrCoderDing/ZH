//
//  UIAlertController+Category.h
//  不忘初心，方得始终。
//
//  Created by HenryVarro on 15/4/26.
//  Copyright © 2015年 丁子恒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockAlert)(UIAlertAction * _Nonnull action);

@interface UIAlertController (Category)


/**
 显示弹窗

 @param title 标题
 @param message 信息
 @param sureTitle 确认标题
 @param suerBlock 确认block
 */
+ (void)alertControllerShowAlertViewWithTitle:(nonnull NSString *)title message:(nonnull NSString *)message sureTitle:(nullable NSString *)sureTitle suerAction:(nonnull blockAlert)suerBlock;



@end
