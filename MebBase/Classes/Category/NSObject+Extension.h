//
//  NSObject+Extension.h
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

@interface NSObject (Extension)


/**
 将Unicode码转换为本地化的字符串

 @param string Unicode码
 @return 转换后的字符串
 */
+ (NSString *)stringByReplaceUnicode:(NSString *)string;

@end
