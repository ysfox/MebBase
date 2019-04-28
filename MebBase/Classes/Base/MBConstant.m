//
//  MBConstant.m
//  MebBase
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

#import "MBConstant.h"

//字符串常量内部定义
#define CFDefineConstStr(name) \
NSString * const name = @#name;

//字符串常量内部定义(带自定义值)
#define CFDefineConstStrValue(name,value) \
NSString * const name = @#value;

//数字常量内部定义
#define CFDefineConstNum(name,num) \
int  const (name) = (num);

/* +++++++++++++++++++++++++++++++++++++ 字符串常量 +++++++++++++++++++++++++++++++++++++++++++ */

/** 用户登录通知 */
CFDefineConstStr(kUserLoginNotification)

/** 用户登出通知 */
CFDefineConstStr(kUserLogoutNotification)

/** 用户登录成功的Token */
CFDefineConstStrValue(kUserLoginSucessToken, userLoginSucessToken)

/* +++++++++++++++++++++++++++++++++++++ 数字串常量 +++++++++++++++++++++++++++++++++++++++++++ */

/** ACK心跳间隔时间 */
CFDefineConstNum(kAckPingTimeInterval, 60)

/** Thrift请求超时时间 */
CFDefineConstNum(kRequestTimeOutInterval, 100000)
