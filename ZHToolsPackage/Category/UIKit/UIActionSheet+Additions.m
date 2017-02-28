//
//  UIActionSheet+Additions.m
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import "UIActionSheet+Additions.h"
#import <objc/runtime.h>

#ifndef SelectBlock
#define SelectBlock @"__SelectBlock"
#endif

@implementation UIActionSheet (Additions)

-(void)setSelectBlock:(void (^)(NSInteger index))select
{
    objc_setAssociatedObject(self, SelectBlock, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(NSInteger index))selectBlock
{
    return objc_getAssociatedObject(self, SelectBlock);
}


+(UIActionSheet *)sheetWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle OtherButtonTitles:(NSArray *)arrayOfOtherTitles
{
    
    NSEnumerator *enumerator=[arrayOfOtherTitles objectEnumerator];
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancleTitle destructiveButtonTitle:nil otherButtonTitles:[enumerator nextObject],    [enumerator nextObject],[enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                [enumerator nextObject],
                                nil];
    return actionSheet;
    
}
+(UIActionSheet *)sheetWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle OtherButtonTitles:(NSArray *)arrayOfOtherTitles  select:(void (^)(NSInteger index))select
{
    UIActionSheet *actionSheet=[UIActionSheet sheetWithTitle:title cancleTitle:cancleTitle OtherButtonTitles:arrayOfOtherTitles];
    actionSheet.delegate=actionSheet;
    actionSheet.selectBlock=select;
    return actionSheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([self selectBlock] !=nil) {
        [self selectBlock](buttonIndex);
    }
}

@end

