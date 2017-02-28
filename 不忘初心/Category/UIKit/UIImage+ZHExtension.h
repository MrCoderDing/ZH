//
//  UIImage+ZHExtension.h
//  不忘初心，方得始终。
//
//  Created by HenryVarro on 15/4/26.
//  Copyright © 2015年 丁子恒. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 计算最多颜色，缩小图片以加快速度
 此为缩小后尺寸，影响结果，越小精确度越小。
 */
#define kZHMostColorSize 50


@interface UIImage (ZHExtension)


/**
 保存图片到本地相册
 @param collectionTitle 本地相册名
 @param completion 完成block
 注：ipad 有可能取不到值, 就用老的保存方法
 */

- (void)saveToCollection:(NSString *)collectionTitle Completion:(void (^)(NSString *errorDescription))completion ;

/**
 *  自由拉伸一张图片
 *
 *  @param name 图片名字
 *  @param left 左边开始位置比例  值范围0-1
 *  @param top  上边开始位置比例  值范围0-1
 *
 *  @return 拉伸后的Image
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  根据颜色和大小获取Image
 *
 *  @param color 颜色
 *  @param size  大小
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  根据图片和颜色返回一张加深颜色以后的图片
 */
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;

/**
 *  根据图片返回一张高斯模糊的图片
 *
 *  @param blur 模糊系数
 *
 *  @return 新的图片
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;

/**
 *  自由改变Image的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)cropImageWithSize:(CGSize)size;

/**
 修正翻转的图片
 若无效果可以尝试下面方法
 @return 修正后的image
 */
- (UIImage *)fixOrientation;


/**
 图片剪裁 + 修正翻转

 @param image 图片
 @param size 尺寸
 @return 修改后图片
 */
+ (UIImage *)cropImage:(UIImage*)image toSize:(CGSize)size;


//最多颜色
- (UIColor*)mostColor;

//黑色白色最多
- (UIColor *)blackOrWhiteMostColor;

/**
 *  多张照片合成一张
 *
 *  @param arr 图片数组
 *
 *  @return 合成的图片
 */
+ (UIImage *)composeImages:(NSArray<UIImage *> *)arr;

+ (UIImage *)composeImages:(NSArray<UIImage *> *)arr Creater:(NSString *)creater;



@end
