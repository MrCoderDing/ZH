//
//  NSDate+Extension.h
//  不忘初心，方得始终。
//
//  Created by HenryVarro on 15/4/26.
//  Copyright © 2015年 丁子恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
/**
 *  判断某个时间是否为同年同月
 */
- (BOOL)isThisMonth;
/**
 *  判断某个时间是否为未来的时间
 */
- (BOOL)isFutureTime;

/**
 *  将NSDate转成字符串
 */
- (NSString *)returnString;


/**
 星期几

 @return 星期几
 */
- (NSString*)weekdayString;

@end
