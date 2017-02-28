//
//  NSDictionary+Additions.h
//  不忘初心，方得始终。
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

/**
 *  @brief  是否存在key值
 *
 *  @param key 键值
 *
 *  @return 是否存在
 */
-(BOOL)existKey:(NSString *)key;

/**
 *  @brief  通过key解析到字符串
 *
 *  @param key 键值
 *
 *  @return 字符串
 */
- (NSString *)stringForKey:(id)key;

/**
 *  @brief  通过key解析到数组
 *
 *  @param key 键值
 *
 *  @return 数组
 */
- (NSArray *)arrayForKey:(id)key;

/**
 *  @brief  通过key解析到字典
 *
 *  @param key 键值
 *
 *  @return 字典
 */
- (NSDictionary *)dictionaryForKey:(id)key;

/**
 *  @brief  通过key解析到Number对象
 *
 *  @param key 键值
 *
 *  @return Number对象
 */
- (NSNumber *)numberForKey:(id)key;

/**
 *  @brief  通过key解析到bool
 *
 *  @param key 键值
 *
 *  @return bool
 */
- (BOOL)boolForKey:(id)key;

/**
 *  @brief  通过key解析到DecimalNumber对象
 *
 *  @param key 键值
 *
 *  @return DecimalNumber对象
 */
- (NSDecimalNumber *)decimalNumberForKey:(id)key;

/**
 *  @brief  通过key解析到Integer
 *
 *  @param key 键值
 *
 *  @return Integer
 */
- (NSInteger)integerForKey:(id)key;

/**
 *  @brief  通过key解析到UInteger
 *
 *  @param key 键值
 *
 *  @return UInteger
 */
- (NSUInteger)unsignedIntegerForKey:(id)key;

/**
 *  @brief  将字典转化为URL传参格式的字符串
 *
 *  @return 字符串
 */
- (NSString *)urlQueryString;

@end
