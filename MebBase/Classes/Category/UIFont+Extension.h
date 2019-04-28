//
//  UIFont+Extension.h
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

@interface UIFont (Extension)

/**
 *  完美字体，根据不同尺寸设备显示相似字体
 *
 *  @return 返回创建的字体
 */
+(UIFont *)prefectFont;

/**
 *  完美字体，副尺寸字体
 *
 *  @return 返回创建的副尺寸完美字体
 */
+(UIFont *)subPrefectFont;

/**
 *  完美字体，大头字体，用于标题
 *
 *  @return 返回大头字
 */
+(UIFont *)headFont;


/**
 *  完美字体，副大头字体,用于副标题
 *
 *  @return 返回副大头字
 */
+(UIFont *)subHeadFont;


/**
 *  协调字体，不加粗
 *
 *  @return 返回不加粗副大头字
 */
+(UIFont *)subLineFont;


/**
 *  返回指定字体名称，指定字体大小的字体，如果没有改指定的文字的按类型，则返回系统字体同样大小的字体
 *
 *  @param fontName 字体名称
 *  @param fontSize 字体大小
 *
 *  @return 返回字体指定创建的字体
 */
+(UIFont *)fontName:(NSString *)fontName fontSize:(CGFloat)fontSize;




/**
 *  HYQiHei-BEJF font (added by plist).
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HYQiHeiWithFontSize:(CGFloat)size;

#pragma mark - System font.

/**
 *  AppleSDGothicNeo-Thin font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size;

/**
 *  Avenir font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AvenirWithFontSize:(CGFloat)size;

/**
 *  Avenir-Light font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size;

/**
 *  Heiti SC font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size;

/**
 *  HelveticaNeue font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size;

/**
 *  HelveticaNeue-Bold font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size;


/**
 *  Helvetica-Bold
 *
 *  @param size Font's size
 *
 *  @return Font
 */
+ (UIFont *)HelveticaBoldFontSize:(CGFloat)size;

@end

