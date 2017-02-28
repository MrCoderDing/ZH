//
//  NSDictionary+Additions.m
//  不忘初心，方得始终。
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

-(BOOL)existKey:(NSString *)key{
    
    return [self objectForKey:key]!=nil;
}
- (NSString *)stringForKey:(id)key{

    id value=[self objectForKey:key];
    if (value==nil ||  value == [NSNull null]) {
        return nil;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;

}
- (NSArray *)arrayForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    else if ([value isKindOfClass:[NSArray class]]){
        return value;
    }else{
        return [NSArray arrayWithObject:value];
    }
    return nil;


}
- (NSDictionary *)dictionaryForKey:(id)key{

    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    else if ([value isKindOfClass:[NSDictionary class]]){
        return value;
    }
    return nil;

}

- (NSNumber *)numberForKey:(id)key{
    
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;


}

- (BOOL)boolForKey:(id)key{

    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]){
        return NO;
    }
    else if ([value isKindOfClass:[NSNumber class]]){
        return [value boolValue];
    }
    else if ([value isKindOfClass:[NSString class]]){
        return [value boolValue];
    }
    return NO;
    


}

- (NSDecimalNumber *)decimalNumberForKey:(id)key{

    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;


}


- (NSInteger)integerForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    else if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]){
        return [value integerValue];
    }
    return 0;

}


- (NSUInteger)unsignedIntegerForKey:(id)key{
    
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    else if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]){
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (NSString *)urlQueryString{
    
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[[self objectForKey:key] description],NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
        [string appendFormat:@"%@=%@", key, escaped];
        CFRelease(escaped);
    }
    return string;
}


@end
