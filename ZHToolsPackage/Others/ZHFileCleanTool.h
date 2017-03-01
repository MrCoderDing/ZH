//
//  ZHFileCleanTool.h
//  不忘初心
//
//  Created by HenryVarro on 17/3/1.
//  Copyright © 2017年 丁子恒. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^complete)();

@interface ZHFileCleanTool : NSObject

/**
 *  计算caches文件夹的大小
 *
 *  @return float类型
 */
+ (float) sizeCachesFile;







/**
 *  清理Caches中的所有文件
 *
 *  @param block 清理Caches之后要做的事情
 */
+ (void) cleanCachesFileComplete:(complete)block;





/**
 *  清理某个文件夹中的所有文件
 *
 *  @param folderPath 文件夹路径
 *  @param block 清理之后要做的事情
 */
+ (void) cleanCachesfolder:(NSString *)folderPath Complete:(complete)block;






/**
 *  计算某个文件夹的大小(/M)
 *
 *  @param folderPath 文件夹的路径
 *
 *  @return float 类型 (/M)
 */
+ (float) folderSizeAtPath:(NSString*) folderPath;






/**
 *  计算某个文件的大小(/B)
 *
 *  @param filePath 文件的路径
 *
 *  @return long long类型 (/Bate)
 */
+ (long long) fileSizeAtPath:(NSString*) filePath;





/**
 *  返回文件夹路径
 *
 */
+ (NSString *)cachesPath;
+ (NSString *)documentPath;
+ (NSString *)libraryPath;
@end
