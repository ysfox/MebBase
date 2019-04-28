//
//  UIApplication+Extention.h
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
//应用的AppleID,请在这里输入你应用在apple store中的ID
#define kApplicationAppleID @"1192686263"

@interface UIApplication (Extention)

/**
 *  获取到应用单例
 *
 *  @return 应用代理
 */
+ (UIApplication *)shareApplication;

/**
 * 退出应用
 */
+ (void)exitApplication;

/**
 *  获取当前应用版本
 *
 *  @return 返回当前应用的版本
 */
+(NSString *)currentVersion;


/**
 *  检测版本更新
 */
+(void)checkVersionUpdate;


/**
 *  检测3Dtouch是否有效
 *
 *  @return 返回是否有效
 */
+(BOOL)check3DtouchAvailable;


/**
 *  修改状态条的颜色
 *
 *  @param color 需要改变的颜色
 */
+(void)changeStatusBarColor:(UIColor *)color;


/**
 *  获取应用代理
 *
 *  @return 返回代理
 */
+(id<UIApplicationDelegate>)getApplicationDelegate;

@end
