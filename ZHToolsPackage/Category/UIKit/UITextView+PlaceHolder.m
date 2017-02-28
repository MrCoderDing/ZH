//
//  UITextView+PlaceHolder.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#define placeHolderFont [UIFont systemFontOfSize:15]

#import "UITextView+PlaceHolder.h"
static const char *phTextView = "placeHolderTextView";
@implementation UITextView (PlaceHolder)
- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, phTextView);
}
- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, phTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)addPlaceHolder:(NSString *)placeHolder {
    if (![self placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = placeHolderFont;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    } else {
        self.placeHolderTextView.text = placeHolder;
    }
    self.placeHolderTextView.hidden = NO;
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
//    self.placeHolderTextView.hidden = YES;
    // if (self.textViewDelegate) {
    //
    // }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *string;
    if (text.length) {
        string = [NSString stringWithFormat:@"%@%@", self.text, string];
    } else {
        if (self.text.length>0) {
            string = [self.text substringWithRange:NSMakeRange(0, self.text.length - 1)];
        }
        
    }
    
    
    NSLog(@"------%@", text);
    // 如果输入框里面有文字，下一步的按钮就能进行交互
    self.placeHolderTextView.hidden = string.length? YES: NO;
    
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    NSLog(@"textViewDidEndEditing----%@", textView.text);
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}

- (void)setContent:(NSString *)content
{
    if (content.length>0) {
        self.placeHolderTextView.hidden = YES;
        self.text = content;
    }
}

@end
