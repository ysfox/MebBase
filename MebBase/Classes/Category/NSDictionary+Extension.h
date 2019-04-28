//
//  NSDictionary+Extension.h
//  AFNetworking
//
//  Created by meb on 2019/4/25.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\      Ysfox **
//**********************************

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)


/**
 转换成JSON串字符串（没有可读性）

 @return 转换后的Json字符串
 */
- (NSString *)toJSONString;


/**
 转换成JSON串字符串（具有可读性）

 @return 转换后的Json字符串
 */
- (NSString *)toReadableJSONString;


/**
 *  转换成JSON数据成NSDate
 *
 *  @return 转换后的NSDate对象
 */
- (NSData *)toJSONData;

@end
