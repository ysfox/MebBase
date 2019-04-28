//
//  UIFont+Extension.m
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

#import "UIFont+Extension.h"
#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
#define ip4_4s     (SCREEN_W == 320.f && SCREEN_H == 480.f ? YES : NO)      //4和4s
#define ip5_5s     (SCREEN_W == 320.f && SCREEN_H == 568.f ? YES : NO)      //5和5s
#define ip6_6s     (SCREEN_W == 375.f && SCREEN_H == 667.f ? YES : NO)      //6和6s
#define ip6_6sPlus (SCREEN_W == 414.f && SCREEN_H == 736.f ? YES : NO)      //6plus

@implementation UIFont (Extension)

/**
 *  完美字体，根据不同尺寸设备显示相似字体
 *
 *  @return 返回创建的字体
 */
+(UIFont *)prefectFont{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    if (ip4_4s) {
        font = [UIFont systemFontOfSize:12.0];
    }
    if(ip5_5s){
        font = [UIFont systemFontOfSize:13.0];
    }
    return font;
}


/**
 *  完美字体，副尺寸字体
 *
 *  @return 返回创建的副尺寸完美字体
 */
+(UIFont *)subPrefectFont{
    UIFont *font = [UIFont systemFontOfSize:12];
    if (ip4_4s) {
        font = [UIFont systemFontOfSize:10.0];
    }
    if(ip5_5s){
        font = [UIFont systemFontOfSize:11.0];
    }
    return font;
}



/**
 *  完美字体，大头字体，用于标题
 *
 *  @return 返回大头字
 */
+(UIFont *)headFont{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    if (ip4_4s) {
        font = [UIFont systemFontOfSize:14.0];
    }
    if(ip5_5s){
        font = [UIFont systemFontOfSize:15.0];
    }
    return font;
}


/**
 *  完美字体，副大头字体,用于副标题
 *
 *  @return 返回副大头字
 */
+(UIFont *)subHeadFont{
    UIFont *font = [UIFont HelveticaBoldFontSize:16];
    if (ip4_4s) {
        font = [UIFont HelveticaBoldFontSize:14];
    }
    if(ip5_5s){
        font = [UIFont HelveticaBoldFontSize:15];
    }
    return font;
}


/**
 *  协调字体，不加粗
 *
 *  @return 返回不加粗副大头字
 */
+(UIFont *)subLineFont{
    UIFont *font = [UIFont HeitiSCWithFontSize:16];
    if (ip4_4s) {
        font = [UIFont HeitiSCWithFontSize:14];
    }
    if(ip5_5s){
        font = [UIFont HeitiSCWithFontSize:15];
    }
    return font;
}



/**
 *  返回指定字体名称，指定字体大小的字体，如果没有改指定的文字的按类型，则返回系统字体同样大小的字体
 *
 *  @param fontName 字体名称
 *  @param fontSize 字体大小
 *
 *  @return 返回字体指定创建的字体
 */
+(UIFont *)fontName:(NSString *)fontName fontSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}



#pragma mark - Added font.

+ (UIFont *)HYQiHeiWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HYQiHei-BEJF" size:size];
}

#pragma mark - System font.

+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:size];
}

+ (UIFont *)AvenirWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Avenir" size:size];
}

+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Avenir-Light" size:size];
}

+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Heiti SC" size:size];
}

+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont *)HelveticaBoldFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"Helvetica-Bold" size:size];
}

@end
