//
//  UIAlertView+Extension.m
//  AFNetworking
//
//  Created by meb on 2019/4/25.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\            **
//**********************************


#import "UIAlertView+Extension.h"
#import <objc/runtime.h>
#define kOkButtonDefaultTitle     @"确定"
#define kCancelButtonDefaultTitle @"取消"
static NSString *UIAlertViewKey = @"UIAlertViewKey";

@implementation UIAlertView (Extension)

+ (void)showWithMessage:(NSString *)message {
    [self showWithTitle:nil message:message];
    return;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message {
    [self showWithTitle:title message:message delegate:nil];
    return;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate {
    [self showWithTitle:title
                message:message
               okButton:kOkButtonDefaultTitle
           cancelButton:kCancelButtonDefaultTitle];
    return;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle {
    [self showWithTitle:title
                message:message
               delegate:nil
               okButton:okButtonTitle
           cancelButton:cancelButtonTitle];
    return;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:okButtonTitle,nil];
    [alertView show];
    return;
}

/*!
 * @brief 带多个按钮的的alertView
 * @param title 标题
 * @param message 内容
 * @param cancelButtonName 取消按钮的名称
 * @param alertViewCallBackBlock 按钮点击的索引block回调
 * @param otherButtonTitles 其他按钮的名称
 */
+ (void)showWithtitle:(NSString *)title
              message:(NSString *)message
     cancelButtonName:(NSString *)cancelButtonName
        callBackBlock:(UIAlertViewCallBackBlock)alertViewCallBackBlock
    otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonName otherButtonTitles: otherButtonTitles, nil];
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [alert addButtonWithTitle:other];
        }
        va_end(args);
    }
    alert.delegate = alert;
    [alert show];
    alert.alertViewCallBackBlock = alertViewCallBackBlock;
}

- (void)setAlertViewCallBackBlock:(UIAlertViewCallBackBlock)alertViewCallBackBlock {
    
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &UIAlertViewKey, alertViewCallBackBlock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
}

- (UIAlertViewCallBackBlock)alertViewCallBackBlock {
    
    return objc_getAssociatedObject(self, &UIAlertViewKey);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.alertViewCallBackBlock) {
        self.alertViewCallBackBlock(buttonIndex);
    }
}


@end
