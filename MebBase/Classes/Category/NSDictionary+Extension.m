//
//  NSDictionary+Extension.m
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

#import "NSDictionary+Extension.h"
#import "NSObject+Extension.m"
#import <objc/runtime.h>

@implementation NSDictionary (Extension)

/**
 加载NSDictionary的时候就去替换掉对应的方法，重写系统这三个方法是为了在日志中能正常显示中文
 */
+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(description)), class_getInstanceMethod([self class], @selector(replaceDescription)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:)), class_getInstanceMethod([self class], @selector(replaceDescriptionWithLocale:)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:indent:)), class_getInstanceMethod([self class], @selector(replaceDescriptionWithLocale:indent:)));
}


/**
 替换NSDictionary的description方法
 
 @return 返回将unicode字符串转换后的字符串
 */
- (NSString *)replaceDescription {
    return [NSObject stringByReplaceUnicode:[self replaceDescription]];
}


/**
 替换NSDictionary的replaceDescriptionWithLocale:方法
 
 @param locale 区域标示
 @return 返回将unicode字符串转换后的字符串
 */
- (NSString *)replaceDescriptionWithLocale:(nullable id)locale {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale]];
}


/**
 替换NSDictionary的descriptionWithLocale:indent:方法
 
 @param locale 区域标示
 @param level 区域级别
 @return 返回将unicode字符串转换后的字符串
 */
- (NSString *)replaceDescriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale indent:level]];
}



/**
 转换成JSON串字符串（没有可读性）
 
 @return 转换后的Json字符串
 */
- (NSString *)toJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
    if (data == nil) {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}



/**
 转换成JSON串字符串（具有可读性）
 
 @return 转换后的Json字符串
 */
- (NSString *)toReadableJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (data == nil) {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}



/**
 *  转换成JSON数据成NSDate
 *
 *  @return 转换后的NSDate对象
 */
- (NSData *)toJSONData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}


@end
