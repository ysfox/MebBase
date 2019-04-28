//
//  UIStoryboard+Extension.m
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

#import "UIStoryboard+Extension.h"

@implementation UIStoryboard (Extension)

/**
 *  显示storybaord的第一个控制器到窗口
 *
 *  @param name storyborad的名称
 */
+(void)showInitialVCWithName:(NSString *)name{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
}


/**
 *  初始化storyboard
 *
 *  @param name storyborad的名称
 *
 *  @return 返回初始化的是对象
 */
+(id)initialVCWithName:(NSString *)name{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    return [storyboard instantiateInitialViewController];
}


/**
 *  初始化话一个storyboard
 *
 *  @param name        storyboard的名称
 *  @param indentifier storyboard的标示
 *
 *  @return 返回实例化对象
 */
+(id)initialVCWithName:(NSString *)name identifier:(NSString *)indentifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:indentifier];
}


@end
