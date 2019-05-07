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
    [self showInitialVCWithName:name fromBundle:nil];
}


/**
 显示指定boundle中的第一个控制器窗口

 @param name storyborad的名称
 @param className 指定类字符串，用于获取指定类所在包名
 */
+(void)showInitialVCWithName:(NSString *)name fromBundle:(NSString *)className{
    NSBundle *bundle = nil;
    if(className){
        bundle = [NSBundle bundleForClass:NSClassFromString(className)];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:bundle];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.rootViewController = storyboard.instantiateInitialViewController;
}


/**
 *  初始化storyboard初始化入口控制器
 *
 *  @param name storyborad的名称
 *
 *  @return 返回初始化的是对象
 */
+(id)initialVCWithName:(NSString *)name{
    return [self initialVCWithName:name fromBundle:nil];
}



/**
 从指定的bundle中初始化指定名称storybard的入口控制器

 @param name storyboard名称
 @param className 指定类字符串，用于获取指定类所在包名
 @return 返回初始化的是对象
 */
+(id)initialVCWithName:(NSString *)name fromBundle:(NSString *)className{
    NSBundle *bundle = nil;
    if(className){
        bundle = [NSBundle bundleForClass:NSClassFromString(className)];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:bundle];
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
    return [self initialFromBundle:name storyBoardName:nil indentifier:indentifier];
}



/**
 从指定的bundle中初始化指定的storyboard中指定标示的控制器

 @param className 指定类字符串，用于获取指定类所在包名
 @param boardName storyboar的名
 @param indentifier vc标示
 @return 返回实例化对象
 */
+(id)initialFromBundle:(NSString *)className
        storyBoardName:(NSString *)boardName
          indentifier:(NSString *)indentifier {
    NSBundle *bundle = nil;
    if(className){
        bundle = [NSBundle bundleForClass:NSClassFromString(className)];
    }
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:boardName bundle:bundle];
    return [storyboard instantiateViewControllerWithIdentifier:indentifier];
}



@end
