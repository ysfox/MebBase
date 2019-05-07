//
//  UIStoryboard+Extension.h
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

@interface UIStoryboard (Extension)

/**
 *  显示storybaord的第一个控制器到窗口
 *
 *  @param name storyborad的名称
 */
+(void)showInitialVCWithName:(NSString *)name;


/**
 显示指定boundle中的第一个控制器窗口
 
 @param name storyborad的名称
 @param className 指定类字符串，用于获取指定类所在包名
 */
+(void)showInitialVCWithName:(NSString *)name fromBundle:(NSString *)className;


/**
 *  初始化storyboard
 *
 *  @param name storyborad的名称
 *
 *  @return 返回初始化的是对象
 */
+(id)initialVCWithName:(NSString *)name;



/**
 从指定的bundle中初始化指定名称storybard的入口控制器
 
 @param name storyboard名称
 @param className 指定类字符串，用于获取指定类所在包名
 @return 返回初始化的是对象
 */
+(id)initialVCWithName:(NSString *)name fromBundle:(NSString *)className;


/**
 *  初始化话一个storyboard
 *
 *  @param name        storyboard的名称
 *  @param indentifier storyboard的标示
 *
 *  @return 返回实例化对象
 */
+(id)initialVCWithName:(NSString *)name identifier:(NSString *)indentifier;


/**
 从指定的bundle中初始化指定的storyboard中指定标示的控制器
 
 @param className 指定类字符串，用于获取指定类所在包名
 @param boardName storyboar的名
 @param indentifier vc标示
 @return 返回实例化对象
 */
+(id)initialFromBundle:(NSString *)className
        storyBoardName:(NSString *)boardName
           indentifier:(NSString *)indentifier;

@end
