//
//  MBConstant.h
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

#import <Foundation/Foundation.h>

//字符串常量开放声明
#define CFDeclareConstStr(name) \
extern NSString *const name;

//数字常量开放声明
#define CFDeclareConstNum(name) \
extern int const (name);

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
CFDeclareConstStr(kUserLoginNotification)

/** 用户登出通知 */
CFDeclareConstStr(kUserLogoutNotification)

/** 用户登录成功的Token */
CFDeclareConstStr(kUserLoginSucessToken)

/* +++++++++++++++++++++++++++++++++++++ 数字串常量 +++++++++++++++++++++++++++++++++++++++++++ */

/** ACK心跳间隔时间 */
CFDeclareConstNum(kAckPingTimeInterval)

/** Thrift请求超时时间 */
CFDeclareConstNum(kRequestTimeOutInterval)

