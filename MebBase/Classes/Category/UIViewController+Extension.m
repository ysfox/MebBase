//
//  UIViewController+Extension.m
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

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

/**
 *  从xib中加载视图控制器,(Xib的名字和视图控制类名一致)
 *
 *  @return 返回实例化对象
 */
+(instancetype)viewControllerFromXib{
    return  [[[self class] alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

@end
