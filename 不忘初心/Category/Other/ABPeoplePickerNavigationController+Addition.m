//
//  ABPeoplePickerNavigationController+Addition.m
//  Mytest
//
//  Created by 黄徐根 on 17/2/7.
//  Copyright © 2017年 youki. All rights reserved.
//

#import "ABPeoplePickerNavigationController+Addition.h"

#import <objc/runtime.h>

#ifndef ABSelectBlock
#define ABSelectBlock @"__ABSelectBlock"
#endif

#ifndef ABParentController
#define ABParentController @"__ABParentController"
#endif


@implementation ABPeoplePickerNavigationController (Addition)


-(void)setParentController:(UIViewController *)vc{
    
    objc_setAssociatedObject(self, ABParentController, vc,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIViewController *)parentController{
    
    return objc_getAssociatedObject(self, ABParentController);
}

-(void)setSelectBlock:(void (^)(NSString  *name, NSString *phoneNumber, BOOL isCancel))select
{
    objc_setAssociatedObject(self, ABSelectBlock, select,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)(NSString  *name, NSString *phoneNumber, BOOL isCancel))selectBlock
{
     return objc_getAssociatedObject(self, ABSelectBlock);
}
+(nonnull instancetype)pickerWithParentController:(UIViewController *)parentController completion:(void (^)(NSString * _Nullable, NSString * _Nullable, BOOL))completion
{
    ABPeoplePickerNavigationController *pickerView =[[ABPeoplePickerNavigationController alloc] init];
    pickerView.peoplePickerDelegate=pickerView;
    
    [pickerView setParentController:parentController];
    
    [pickerView setSelectBlock:completion];
    
    pickerView.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
    {
        if ([pickerView respondsToSelector:@selector(setPredicateForSelectionOfPerson:)])
        {
             pickerView.predicateForSelectionOfPerson = [NSPredicate predicateWithFormat:@"%K.@count < 2", ABPersonPhoneNumbersProperty];
        }
    }
    return pickerView;
}

-(void)show
{
    if (!self.parentViewController)
    {
        self.parentController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    }
    [self.parentViewController presentViewController:self animated:YES completion:nil];
}

#pragma mark -AB 代理
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self resultSelected:nil phone:nil isCancel:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    ABMultiValueRef phones=(ABMultiValueRef)ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSInteger count=ABMultiValueGetCount(phones);
    if (count>1)
    {
        return YES;
    }
    else if(count==1){
        [self dismissViewControllerAnimated:YES completion:nil];
        NSString *number =[self getPhoneNumberWithPhones:phones index:0];
        NSString *name =[self getNameWithPerson:person];
        [self resultSelected:name phone:number isCancel:NO];
    }
    return NO;
    
}
// iOS(6_0, 7_0)
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    ABMultiValueRef values = ABRecordCopyValue(person, property);
    CFIndex index = ABMultiValueGetIndexForIdentifier(values, identifier);
    
    NSString *number =[self getPhoneNumberWithPhones:values index:index];
    NSString *name =[self getNameWithPerson:person];
    
    [self resultSelected:name phone:number isCancel:NO];
    
    return NO;
}

//iOS(8_0)
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    
    ABMultiValueRef phones = (ABMultiValueRef)ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    NSString *number = [self getPhoneNumberWithPhones:phones index:0];
    NSString *name = [self getNameWithPerson:person];
    
    [self resultSelected:name phone:number isCancel:NO];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    ABMultiValueRef values = ABRecordCopyValue(person, property);
    CFIndex index = ABMultiValueGetIndexForIdentifier(values, identifier);
    
    NSString *number = [self getPhoneNumberWithPhones:values index:index];
    NSString *name = [self getNameWithPerson:person];
    
    [self resultSelected:name phone:number isCancel:NO];
}

//获取手机号码
- (NSString *)getPhoneNumberWithPhones:(ABMultiValueRef)phones index:(NSUInteger)index{
    
    NSString * phoneNum = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, index));
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    NSString *allowString = @"0123456789";
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:allowString] invertedSet];
    phoneNum = [phoneNum stringByTrimmingCharactersInSet:characterSet];
    
    return phoneNum;
}

#pragma mark -获取名字

- (NSString *)getNameWithPerson:(ABRecordRef)person{
    //名
    NSString *personName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (personName ==nil) {
        personName = @"";
    }
    //姓
    NSString *lastname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (lastname ==nil) {
        lastname = @"";
    }
    //姓名拼接
    NSString * name =[NSString stringWithFormat:@"%@%@", lastname, personName];
    
    return name;
}




-(void)resultSelected:(NSString *)name phone:(NSString *)phoneNumber isCancel:(BOOL)isCancel
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.selectBlock) {
            self.selectBlock(name,phoneNumber,isCancel);
        }
    });
}

@end
