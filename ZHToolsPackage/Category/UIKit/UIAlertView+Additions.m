//
//  UIAlertView+Additions.m
//  testDemo
//
//  Created by HenryVarro on 16/4/18.
//  Copyright © 2016年 ZYNaNian. All rights reserved.
//

#import "UIAlertView+Additions.h"
#import <objc/runtime.h>

#ifndef SelectBlock
#define SelectBlock @"__SelectBlock"
#endif
@implementation UIAlertView (Additions)

-(void)setSelectBlock:(void (^)(NSInteger index))select{

    objc_setAssociatedObject(self, SelectBlock, select,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(NSInteger index))selectBlock{
    
    return objc_getAssociatedObject(self, SelectBlock);
}

/**
 *  @brief 构造UIAlertView
 *
 *  @param title             标题
 *  @param message           内容
 *  @param buttonIndex       选中 block
 *  @param cancelButtonTitle 取消按钮
 *  @param otherButtonTitles 其他按钮数组
 *
 *  @return UIAlertView
 */
+ (UIAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message  buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle arrayOfOtherButtons:(NSArray *)otherButtonTitles{

    NSEnumerator *enumerator =[otherButtonTitles objectEnumerator];
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:[enumerator nextObject],[enumerator nextObject],[enumerator nextObject],[enumerator nextObject],[enumerator nextObject],[enumerator nextObject],[enumerator nextObject],[enumerator nextObject],[enumerator nextObject],[enumerator nextObject], nil];
    
    alert.selectBlock =buttonIndex;

    alert.delegate =alert;
    
    return alert;
}

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
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message  buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION{
    
    NSMutableArray *titles =[[NSMutableArray alloc]init];
    if (otherButtonTitles){
        if ([otherButtonTitles isKindOfClass:NSString.class]){
            [titles addObject:otherButtonTitles];
        }
        va_list argumentList;
        va_start(argumentList, otherButtonTitles);
        id buttonTitle =va_arg(argumentList, NSString *);
        if (buttonTitle && [buttonTitle isKindOfClass:NSString.class]){
            [titles addObject:buttonTitle];
        }
        va_end(argumentList);
    }
    
    UIAlertView *alert =[UIAlertView alertWithTitle:title message:message buttonIndex:buttonIndex cancelButtonTitle:cancelButtonTitle arrayOfOtherButtons:titles];
    
    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.selectBlock) {
        self.selectBlock(buttonIndex);
    }
}

@end
