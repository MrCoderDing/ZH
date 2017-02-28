//
//  UIAlertController+Category.m
//  不忘初心，方得始终。
//
//  Created by HenryVarro on 15/4/26.
//  Copyright © 2015年 丁子恒. All rights reserved.
//

#import "UIAlertController+Category.h"

@implementation UIAlertController (Category)



+ (void)alertControllerShowAlertViewWithTitle:(NSString *)title message:(NSString *)message sureTitle:(NSString *)sureTitle suerAction:(blockAlert)suerBlock{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * enter = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        suerBlock(action);
    }];
    [alert addAction:enter];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancle];
    
    
    [alert show];
    
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}


@end
