//
//  UIWindow+Extension.h
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

@interface UIWindow (Extension)

/**
 *  获取到根窗口
 *
 *  @return 返回根窗口
 */
+ (UIWindow *)baseWindow;

/**
 *  获取最顶端的视图控制器
 *
 *  @return 返回最顶端的视图控制器
 */
+ (UIViewController *)topMostViewController;

/**
 *  获取最顶端的导航控制器
 *
 *  @return 返回最顶端的导航控制器
 */
+ (UINavigationController *)topMostNavigationController;

/**
 *  获取到最顶端的非modal形式的视图控制器
 *
 *  @return 返回最顶端的视图控制器
 */
+ (UIViewController *)topMostNonModalViewController;

/**
 *  切换根视图控制器
 */
- (void)switchRootViewController;


/**
 *  切换根视图到登录控制器
 */
- (void)switchLoginController;

/**
 *  切换根视图到新特性控制器
 */
- (void)switchMainController;

/**
 *  显示登录闪图
 */
+ (void)showSplashView;



/**
 *  添加模糊效果，主要用户应用进入后台
 */
+ (void)addBlurEffect;


/**
 *  移除模糊效果，主要用于应用进入前台
 */
+ (void)removeBlurEffect;

@end
