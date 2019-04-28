//
//  UIAlertView+Extension.h
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


#import <UIKit/UIKit.h>

typedef void(^UIAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (Extension)

/*!
 * @brief 默认会带有确定和取消按钮
 * @param message 标题
 */
+ (void)showWithMessage:(NSString *)message;

/*!
 * @brief 默认会带有确定和取消按钮，需要标题和内容参数
 * @param title 标题
 * @param message 内容
 */
+ (void)showWithTitle:(NSString *)title message:(NSString *)message;

/*!
 * @brief 默认会带有确定和取消按钮，需要标题和内容参数
 * @param title 标题
 * @param message 内容
 * @param delegate 代理
 */
+ (void)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate;

/*!
 * @brief 需要标题和内容参数,确定和取消按钮标题
 * @param title 标题
 * @param message 内容
 * @param okButtonTitle 确定标题
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle;

/*!
 * @brief 需要标题和内容参数，代理，确定和取消按钮标题
 * @param title 标题
 * @param message 内容
 * @param delegate 代理
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle;


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
    otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end

