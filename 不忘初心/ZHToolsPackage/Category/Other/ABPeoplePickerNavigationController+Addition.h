//
//  ABPeoplePickerNavigationController+Addition.h
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>

@interface ABPeoplePickerNavigationController (Addition)<ABPeoplePickerNavigationControllerDelegate>
/**
 *  @brief 构造ABPeoplePickerNavigationController
 *
 *  @param parentController 父级控制器
 *  @param completion       点击回调，处理成名字和号码，是否取消
 *
 *  @return ABPeoplePickerNavigationController
 */
+(nonnull instancetype)pickerWithParentController:(nullable UIViewController *)parentController completion:(void (^_Nullable)(NSString *_Nullable name, NSString *_Nullable phoneNumber, BOOL isCancel))completion;

/**
 *  @brief 显示
 */
-(void)show;

@end
