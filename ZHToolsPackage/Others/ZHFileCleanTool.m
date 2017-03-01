//
//  ZHFileCleanTool.m
//  不忘初心
//
//  Created by HenryVarro on 17/3/1.
//  Copyright © 2017年 丁子恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFileCleanTool.h"

#define FC_CachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define FC_DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define FC_LibraryPath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]



#define FC_ScreenW [UIScreen mainScreen].bounds.size.width
#define FC_ScreenH [UIScreen mainScreen].bounds.size.height


// 判断是不是iOS8以上系列
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 清理进度时 弹框的大小

#define FC_HUBW 200
#define FC_HUBH 90
@interface ZHFileCleanTool ()

@property (nonatomic ,retain) UIProgressView * progressView;

@property (nonatomic ,retain) UIView * backgroundView;

@property (nonatomic ,retain) UILabel * label;
@end


@implementation ZHFileCleanTool
{
    UIAlertController * alertController;
    UIAlertAction * sureClean;
    UIAlertAction * cancleClean;
    
    complete blockTemp;
    NSString *folderPathTemp;
}



/**
 *  计算caches文件夹的大小
 *
 *  @return float类型
 */
+ (float) sizeCachesFile{
    return [self folderSizeAtPath:FC_CachesPath];
}


/**
 *  清理Caches中的所有文件
 *
 *  @param block 清理Caches之后要做的事情
 */
+ (void) cleanCachesFileComplete:(complete)block{
    
    [self cleanCachesfolder:FC_CachesPath Complete:block];
    
}




+ (void) cleanCachesfolder:(NSString *)folderPath Complete:(complete)block{
    
    if (![self isNeedClearFolder:folderPath]) return;
      [self dispatchClearFilefolder:folderPath Complete:block];
    
    
}

/**
 *  计算某个文件夹的大小
 *
 *  @param folderPath 文件夹的路径
 *
 *  @return float 类型
 */
+ (float) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        manager = nil;
        return 0;
    }
    
    NSArray * subpaths = [manager subpathsAtPath:folderPath];
    long long folderSize = 0;
    NSString* fileAbsolutePath;
    for (NSString * fileName in subpaths) {
        fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    subpaths = nil;
    return folderSize/(1024.0*1024.0);
}



/**
 *  计算某个文件的大小
 *
 *  @param filePath 文件的路径
 *
 *  @return long long类型
 */
+ (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]){
        manager = nil;
        return 0;
    }
    return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
}




/**
 *  返回文件夹路劲
 *
 *  @return 字符串
 */
+ (NSString *)cachesPath{
    return FC_CachesPath;
}
+ (NSString *)documentPath{
    return FC_DocumentPath;
}
+ (NSString *)libraryPath{
    return FC_LibraryPath;
}





#pragma mark - 私有方法
// 判断是否需要清理缓存
+ (BOOL)isNeedClearFolder:(NSString *)folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        manager = nil;
        [self notSureClean];
        return NO;
    }
    
    NSArray * subpaths = [manager subpathsAtPath:folderPath];
    if (subpaths.count == 0) {
        [self notSureClean];
        return NO;
    }
    manager = nil;
    subpaths = nil;
    return YES;
}



// 异步清理
+ (void)dispatchClearFilefolder:(NSString *)folderPath Complete:(complete)block{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
        
        float SUM = [ZHFileCleanTool folderSizeAtPath:folderPath];
        NSString *path;
        float progress;
        for (NSString *subpath in files) {
            path = [folderPath stringByAppendingPathComponent:subpath];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            }
            progress = (SUM -[ZHFileCleanTool folderSizeAtPath:folderPath]) / SUM;
            
            [self performSelectorOnMainThread:@selector(progressShow:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:YES];
            
        }
        
        [self performSelectorOnMainThread:@selector(clearCacheSuccess:) withObject:block waitUntilDone:YES];
    });
}



// 清理完成之后的工作
+ (void) clearCacheSuccess:(complete)block
{
    
    [[self shareFileCleanTool].backgroundView removeFromSuperview];
    [self shareFileCleanTool].backgroundView = nil;
    [self shareFileCleanTool].label = nil;
    [self shareFileCleanTool].progressView = nil;
    if(block){
        block();
    }
    return;
    
}




// 清理过程中频繁调用的方法 -- 设置清理进度
+ (void) progressShow:(NSNumber *)progress{
    [self shareFileCleanTool].progressView.progress = [progress floatValue];
    [self shareFileCleanTool].label.text = [NSString stringWithFormat:@"正在清理,请稍后...%.2f％",[progress floatValue] * 100.0];
}




// dismissController
+ (void) dismissController:(UIViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
    viewController = nil;
}


// 不需要清理缓存
+ (void) notSureClean{
    
    [self showAlertView:@"温馨提示" Message:@"您的缓存区已经够干净了！" ActionTitle:@"知道了！"];
    
}


// ActionSheet 弹框方法
UIAlertAction * alertA;
UIAlertController * alertC;
+ (void) showAlertView:(NSString *)title Message:(NSString *)message ActionTitle:(NSString *)actionTitle{
    alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    alertA = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertC addAction:alertA];
    
    [[[UIApplication sharedApplication].windows lastObject].rootViewController presentViewController:alertC animated:YES completion:nil];
    
}


#pragma mark - 懒加载
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FC_HUBW, 20)];
        _label.center = CGPointMake(FC_HUBW / 2, FC_HUBH /2 + 15);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont boldSystemFontOfSize:14];
    }
    return _label;
}

- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _backgroundView;
}


- (UIProgressView *)progressView{
    if (_progressView == nil) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FC_HUBW, FC_HUBH)];
        [view addSubview:self.label];
        
        view.center = self.backgroundView.center;
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.85];
        [self.backgroundView addSubview:view];
        
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((FC_HUBW - 40) / 2, (FC_HUBH - 60)/ 2 , 40, 40)];
        [activityView startAnimating];
        [view addSubview:activityView];
        
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, FC_HUBH - 11, FC_HUBW, 20)];
        _progressView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
        _progressView.tintColor = [UIColor greenColor];
        [view addSubview:_progressView];
        
        
        [[[UIApplication sharedApplication].windows lastObject].rootViewController.view addSubview:self.backgroundView];
        
    }
    return _progressView;
}


#pragma mark - 单例创建方法 私用
static ZHFileCleanTool * tools;
+ (ZHFileCleanTool *) shareFileCleanTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
    });
    return tools;
}
@end
