//
//  ZHUtils.h
//  不忘初心
//
//  Created by HenryVarro on 17/2/28.
//  Copyright © 2017年 丁子恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHUtils : NSObject



/**
 打电话

 @param phone       电话号码
 @param completion  回调
 */
+ (void)callWithPhoneNumber:(NSString *)phone completion:(void(^)(BOOL success))completion;



/**
 验证邮箱是否正确

 @param email       电子邮箱
 @return            正确与否
 */
+ (BOOL)isValidateEmail:(NSString *)email;





/**
 验证手机号

 @param mobile      手机号
 @return            正确与否
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;




/**
 身份证验证

 @param identityCard 身份证
 @return            正确与否
 */
+ (BOOL)isValidateIDCard:(NSString *)identityCard;





/**
 车牌号验证

 @param carNo       车牌号
 @return            正确与否
 */
+ (BOOL)isValidateCarNo:(NSString *)carNo;



///获得某个NSDate的农历表示法
+ (NSString*)getChineseCalendarWithDate:(NSDate *)date;
@end
