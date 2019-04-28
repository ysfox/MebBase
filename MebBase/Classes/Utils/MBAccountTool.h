//
//  MBAccountTool.h
//  MebBase_Example
//
//  Created by meb on 2019/4/25.
//  Copyright © 2019 ysfox. All rights reserved.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\      Ysfox **
//**********************************

#import <Foundation/Foundation.h>

@interface MBAccountTool : NSObject

/**
 *  判断用户是否登录
 *
 *  @return 返回是否登录
 */
+(BOOL)hadLogin;

/**
 *  设置用户是否登录
 *
 *  @param hadLogin 设置的值
 */
+(void)setLogin:(BOOL)hadLogin;

@end
