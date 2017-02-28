//
//  ViewController.m
//  不忘初心
//
//  Created by HenryVarro on 17/2/7.
//  Copyright © 2017年 丁子恒. All rights reserved.
//

#import "ViewController.h"
#import "ZHHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(200, 200)];
    [img saveToCollection:@"哈哈哈" Completion:^(NSString *errorDescription) {
        if (!errorDescription) {
            [UIAlertController alertControllerShowAlertViewWithTitle:@"haha" message:@"这是一条信息" sureTitle:@"知道了" suerAction:^(UIAlertAction * _Nonnull action) {
                ZHLog(@"知道了");
            }];
        }
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
