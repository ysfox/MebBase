//
//  UIApplication+Extention.m
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

#import "UIApplication+Extention.h"
#import <objc/runtime.h>

@implementation UIApplication (Extention)

/**
 *  载入的时候
 */
+ (void)load{
    if (![[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"]) {
        Method sharedApplicationMethod = class_getClassMethod([UIApplication class], @selector(sharedApplication));
        if (sharedApplicationMethod != NULL) {
            IMP sharedApplicationMethodImplementation = method_getImplementation(sharedApplicationMethod);
            Method rsk_sharedApplicationMethod = class_getClassMethod([UIApplication class], @selector(shareApplication));
            method_setImplementation(rsk_sharedApplicationMethod, sharedApplicationMethodImplementation);
        }
    }
}


/**
 *  获取到应用单例
 *
 *  @return 应用代理
 */
+ (UIApplication *)shareApplication{
    return [UIApplication sharedApplication];
}


/**
 * 退出应用
 */
+ (void)exitApplication{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if(!window){
        window = [[UIApplication sharedApplication] keyWindow];
    }
    [UIView animateWithDuration:0.3f animations:^{
        window.alpha = 0;
        window.bounds = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}


/**
 *  获取当前应用版本
 *
 *  @return 返回当前应用的版本
 */
+(NSString *)currentVersion{
    NSString *key = @"CFBundleVersion";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    return currentVersion;
}


/**
 *  检测版本更新
 */
+(void)checkVersionUpdate{
    //http://itunes.apple.com/lookup?id=1192686263
    NSString *appStoreUrl = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kApplicationAppleID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
    
}


/**
 *  检测3Dtouch是否有效
 *
 *  @return 返回是否有效
 */
+(BOOL)check3DtouchAvailable{
    BOOL ret = NO;
    if (@available(iOS 9.0, *)) {
        UIForceTouchCapability c = [UIApplication sharedApplication].keyWindow.rootViewController.traitCollection.forceTouchCapability;
        if(UIForceTouchCapabilityAvailable == c){
            ret = YES;
        }
    } else {
        ret = NO;
    }
    return ret;
}


/**
 *  修改状态条的颜色
 *
 *  @param color 需要改变的颜色
 */
+(void)changeStatusBarColor:(UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

/**
 *  获取应用代理
 *
 *  @return 返回代理
 */
+(id<UIApplicationDelegate>)getApplicationDelegate{
    return [UIApplication sharedApplication].delegate;
}

@end
