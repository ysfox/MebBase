//
//  NSArray+Extension.m
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

#import "NSArray+Extension.h"
#import "NSObject+Extension.m"
#import <objc/runtime.h>

@implementation NSArray (Extension)


/**
 加载NSArray的时候就去替换掉对应的方法，重写系统这三个方法是为了在日志中能正常显示中文
 */
+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(description)), class_getInstanceMethod([self class], @selector(replaceDescription)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:)), class_getInstanceMethod([self class], @selector(replaceDescriptionWithLocale:)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:indent:)), class_getInstanceMethod([self class], @selector(replaceDescriptionWithLocale:indent:)));
}



/**
 替换NSArray的description方法

 @return 返回将unicode字符串转换后的字符串
 */
- (NSString *)replaceDescription {
    return [NSObject stringByReplaceUnicode:[self replaceDescription]];
}



/**
 替换NSArray的replaceDescriptionWithLocale:方法

 @param locale 区域标示
 @return 返回将unicode字符串转换后的字符串
 */
- (NSString *)replaceDescriptionWithLocale:(nullable id)locale {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale]];
}



/**
 替换NSArray的descriptionWithLocale:indent:方法

 @param locale 区域标示
 @param level 区域级别
 @return 返回将unicode字符串转换后的字符串
 */
- (NSString *)replaceDescriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale indent:level]];
}

@end
