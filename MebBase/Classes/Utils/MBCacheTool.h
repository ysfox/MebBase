//
//  MBCacheTool.h
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
#import <UIKit/UIKit.h>

@interface MBCacheTool : NSObject

#pragma mark - 小数据的存储

/**
 *  根据指定的名称存储值
 *
 *  @param value       字符串值，要求该Value是NSValue类型
 *  @param defaultName 指定的键名
 */
+ (void)setObject:(id)value forKey:(NSString *)defaultName;


/**
 *  根据指定的名称获取值获取值
 *
 *  @param defaultName 指定的键名
 *
 *  @return 返回获取到的结果对象
 */
+ (id)objectForKey:(NSString *)defaultName;


/**
 *  根据指定的名称存储模型，需要注意存储模型的模型需要遵循NSCopy协议
 *
 *  @param modelValue 模型，要求该模型实现NSCopy协议，能够实现归档解档案
 *  @param modelName  模型名称
 */
+ (void)setModelObject:(id)modelValue forKey:(NSString *)modelName;

/**
 *  根据指定的名称名称获取模型
 *
 *  @param modelName 模型名称
 *
 *  @return 返回模型对象
 */
+ (id)modelForKey:(NSString *)modelName;


/**
 *  根据指定的名称存储BOOL值
 *
 *  @param value       bool值
 *  @param defaultName bool值对应的键名
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;


/**
 *  获取对应键名的bool值
 *
 *  @param defaultName 键名
 *
 *  @return 返回获取到的结果
 */
+ (BOOL)boolForKey:(NSString *)defaultName;


/**
 *  归档图片的方法
 *
 *  @param image     图片
 *  @param imageName 存储图片名称
 */
+ (void)archiveImage:(UIImage *)image imageName:(NSString *)imageName;


/**
 *  接档图片的方法
 *
 *  @param imageName 存储图片的名称
 *
 *  @return 返回接档的图片
 */
+ (UIImage *)unArchivedImageWithName:(NSString *)imageName;


/**
 *  清理指定键名称的数据
 *
 *  @param key 指定键名称
 */
+ (void)removeObjectWithKey:(NSString *)key;


#pragma mark - 计算文件和清理缓存
/**
 *  计算单个文件的大小
 *
 *  @param path 文件路径
 *
 *  @return 返回文件的大小
 */
+(long long)fileSizeAtPath:(NSString *)path;


/**
 *  指定路径下文件夹的大小
 *
 *  @param folderPath 文件夹路劲
 *
 *  @return 返回文件大小
 */
+(float )folderSizeAtPath:(NSString*)folderPath;



/**
 *  异步清理文件夹
 *
 *  @param path     指定的文件夹路径
 *  @param complate 清理完毕后的回调block
 */
+ (void)cleanFolder:(NSString *)path complate:(void (^)(void))complate;

@end
