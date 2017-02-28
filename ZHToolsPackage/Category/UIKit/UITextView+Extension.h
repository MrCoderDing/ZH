//
//  UITextView+Extension.h
//  ZYNaNian
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 ZYNaNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
