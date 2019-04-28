//
//  UITextField+Extension.h
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

@interface UITextField (Extension)

/**
 *  modify default placeholder padding
 */
@property (assign,nonatomic) CGFloat leftPadding;
/**
 *  modify default placeholder color
 */
@property (strong,nonatomic) UIColor *placeHolderColor;


/**
 *  快速创建文本输入框
 *
 *  @param frame          尺寸
 *  @param placeholder    提示字体
 *  @param isPassWord     是否是密码
 *  @param leftImageView  左边图片
 *  @param rightImageView 右边图片
 *  @param font           字体
 *
 *  @return 返回输入框
 */
+(UITextField*)textFieldWithFrame:(CGRect)frame
                      placeholder:(NSString*)placeholder
                       isPassWord:(BOOL)isPassWord
                    leftImageView:(UIImageView*)leftImageView
                   rightImageView:(UIImageView*)rightImageView
                             font:(float)font;

@end

