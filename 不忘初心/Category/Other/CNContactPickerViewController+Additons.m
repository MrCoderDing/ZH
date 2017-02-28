//
//  ABPeoplePickerNavigationController+Addition.h
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import "CNContactPickerViewController+Additons.h"
#import <objc/runtime.h>

#ifndef CNSelectBlock
#define CNSelectBlock @"__SelectBlock"
#endif

#ifndef CNParentController
#define CNParentController @"__CNParentController"
#endif
@implementation CNContactPickerViewController (Additons)

-(void)setParentController:(UIViewController *)vc{
    
    objc_setAssociatedObject(self, CNParentController, vc,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIViewController *)parentController{
    
    return objc_getAssociatedObject(self, CNParentController);
}

-(void)setSelectBlock:(void (^)(NSString  *name, NSString *phoneNumber, BOOL isCancel))select{
    
    objc_setAssociatedObject(self, CNSelectBlock, select,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(NSString *name, NSString *phoneNumber, BOOL isCancel))selectBlock{
    
    return objc_getAssociatedObject(self, CNSelectBlock);
}

+(nonnull instancetype)pickerWithParentController:(nullable UIViewController *)parentController completion:(void (^_Nullable)(NSString *_Nullable name, NSString *_Nullable phoneNumber, BOOL isCancel))completion;{
    
    CNContactPickerViewController *pickerView =[[CNContactPickerViewController alloc] init];
    //代理
    pickerView.delegate= pickerView;
    //父级视图
    pickerView.parentController =parentController;
    //点击回调
    pickerView.selectBlock =completion;
    
    return pickerView;
}

-(void)show{
    
    if (!self.parentController) {
        self.parentController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    }
    [self.parentController presentViewController:self animated:YES completion:nil];
}

#pragma mark -处理block

-(void)resultSelected:(NSString *)name phone:(NSString *)phoneNumber isCancel:(BOOL)isCancel{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.selectBlock) {
            self.selectBlock(name,phoneNumber,isCancel);
        }
    });
}

#pragma mark -CNContactPickerDelegate

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [self resultSelected:nil phone:nil isCancel:YES];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    if ([contactProperty.key isEqualToString: CNContactPhoneNumbersKey]) {
        NSString *phoneNumber = [contactProperty.value stringValue];
        phoneNumber = [self getPhoneNumberWithPhones:phoneNumber];
        NSString *name =[self getNameWithCNContact:contactProperty.contact];
        if (phoneNumber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.selectBlock) {
                    self.selectBlock(name,phoneNumber,NO);
                }
            });
        }
    }
}

//获取手机号码
- (NSString *)getPhoneNumberWithPhones:(NSString *)phoneNum{
    
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    NSString *allowString = @"0123456789";
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:allowString] invertedSet];
    phoneNum = [phoneNum stringByTrimmingCharactersInSet:characterSet];
    
    return phoneNum;
}

-(NSString *)getNameWithCNContact:(CNContact *)contact{
    //名
    NSString *personName =contact.givenName;
    if (personName ==nil) {
        personName = @"";
    }
    //姓
    NSString *lastname =contact.familyName;
    if (lastname ==nil) {
        lastname = @"";
    }
    //姓名拼接
    NSString * name =[NSString stringWithFormat:@"%@%@", lastname, personName];
    
    return name;
}
@end
