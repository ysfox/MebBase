//
//  UIViewController+Extension.h
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

@interface UIViewController (Extension)

/**
 *  从xib中加载视图控制器,(Xib的名字和视图控制类名一致)
 *
 *  @return 返回实例化对象
 */
+(instancetype)viewControllerFromXib;

@end

