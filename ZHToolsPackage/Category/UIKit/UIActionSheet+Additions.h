//
//  UIActionSheet+Additions.h
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @brief UIActionSheet扩展
 */
@interface UIActionSheet (Additions)<UIActionSheetDelegate>

/*!
 *  @brief  构造UIActionSheet
 *
 *  @param cancleTitle        取消标题
 *  @param arrayOfOtherTitles 其他标题数组
 *
 *  @return UIActionSheet
 */
+(UIActionSheet *)sheetWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle OtherButtonTitles:(NSArray *)arrayOfOtherTitles;

/*!
 *  @brief  构造UIActionSheet
 *
 *  @param cancleTitle        取消标题
 *  @param arrayOfOtherTitles 其他标题数组
 *  @param select             选中 block
 *
 *  @return UIActionSheet
 */
+(UIActionSheet *)sheetWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle OtherButtonTitles:(NSArray *)arrayOfOtherTitles  select:(void (^)(NSInteger index))select;

@end
