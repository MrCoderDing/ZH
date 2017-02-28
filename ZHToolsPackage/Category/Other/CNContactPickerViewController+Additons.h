//
//  ABPeoplePickerNavigationController+Addition.h
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//
#import <ContactsUI/ContactsUI.h>

#import <ContactsUI/ContactsUI.h>

typedef void (^PCContactRelay)(NSString *_Nullable name, NSString *_Nullable phoneNumber, BOOL isCancel);

/**
 CNContactPickerViewController block扩展
 */
@interface CNContactPickerViewController (Additons)<CNContactPickerDelegate>
/**
 *  @brief 构造CNContactPickerViewController
 *
 *  @param parentController 父级控制器
 *  @param completion       点击回调，处理成名字和号码，是否取消
 *
 *  @return CNContactPickerViewController
 */
+(nonnull instancetype)pickerWithParentController:(nullable UIViewController *)parentController completion:(void (^_Nullable)(NSString *_Nullable name, NSString *_Nullable phoneNumber, BOOL isCancel))completion;

/**
 显示
 */
-(void)show;

@end
