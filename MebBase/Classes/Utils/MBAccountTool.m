//
//  MBAccountTool.m
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

#import "MBAccountTool.h"
#import "MBCacheTool.h"
static NSString *kUserHadLogin          = @"kUserHadLoginIdentifer";             //用户登录标示

@implementation MBAccountTool

/**
 *  判断用户是否登录
 *
 *  @return 返回是否登录
 */
+(BOOL)hadLogin{
    return [MBCacheTool boolForKey:kUserHadLogin];
}

/**
 *  设置用户是否登录
 *
 *  @param hadLogin 设置的值
 */
+(void)setLogin:(BOOL)hadLogin{
    [MBCacheTool setBool:hadLogin forKey:kUserHadLogin];
}

@end
