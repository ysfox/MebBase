//
//  UITextView+Extension.h
//  AFNetworking
//
//  Created by meb on 2019/4/26.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\            **
//**********************************

#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

@interface UITextView (Extension)

/**
 *  插入文本属性
 *
 *  @param text 文本属性
 */
- (void)insertAttributedText:(NSAttributedString *)text;

/**
 *  插入文本属性
 *
 *  @param text         文本属性
 *  @param settingBlock 设置回调blcok
 */
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;


#pragma mark - palceHoder
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;


@end
