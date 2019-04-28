//
//  MBCacheTool.m
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

#import "MBCacheTool.h"

@implementation MBCacheTool
#pragma mark - 小数据的存储

/**
 *  根据指定的名称存储值
 *
 *  @param value       字符串值，要求该Value是NSValue类型
 *  @param defaultName 指定的键名
 */
+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  根据指定的名称获取值获取值
 *
 *  @param defaultName 指定的键名
 *
 *  @return 返回获取到的结果对象
 */
+ (id)objectForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}


/**
 *  根据指定的名称存储模型，需要注意存储模型的模型需要遵循NSCopy协议
 *
 *  @param modelValue 模型，要求该模型实现NSCopy协议，能够实现归档解档案
 *  @param modelName  模型名称
 */
+ (void)setModelObject:(id)modelValue forKey:(NSString *)modelName{
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:modelValue];
    [[NSUserDefaults standardUserDefaults] setObject:modelData forKey:modelName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  根据指定的名称名称获取模型
 *
 *  @param modelName 模型名称
 *
 *  @return 返回模型对象
 */
+ (id)modelForKey:(NSString *)modelName{
    NSData *modelData = [MBCacheTool objectForKey:modelName];
    if (modelData) {
        id data = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
        return data;
    }
    return nil;
}


/**
 *  根据指定的名称存储BOOL值
 *
 *  @param value       bool值
 *  @param defaultName bool值对应的键名
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  获取对应键名的bool值
 *
 *  @param defaultName 键名
 *
 *  @return 返回获取到的结果
 */
+ (BOOL)boolForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}


/**
 *  归档图片的方法
 *
 *  @param image     图片
 *  @param imageName 存储图片名称
 */
+ (void)archiveImage:(UIImage *)image imageName:(NSString *)imageName{
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q, ^{
        NSData *userImageData = [NSKeyedArchiver archivedDataWithRootObject:image];
        if (nil != userImageData) {
            [MBCacheTool setObject:userImageData forKey:imageName];
        }
    });
}


/**
 *  接档图片的方法
 *
 *  @param imageName 存储图片的名称
 *
 *  @return 返回接档的图片
 */
+ (UIImage *)unArchivedImageWithName:(NSString *)imageName{
    NSData *imageData =  [MBCacheTool objectForKey:imageName];
    UIImage *image = nil;
    if (imageData) {
        image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
    }
    return image;
}


/**
 *  清理指定键名称的数据
 *
 *  @param key 指定键名称
 */
+ (void)removeObjectWithKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - 计算文件和清理缓存
/**
 *  计算单个文件的大小
 *
 *  @param path 文件路径
 *
 *  @return 返回文件的大小
 */
+(long long)fileSizeAtPath:(NSString *)path{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;
}


/**
 *  指定路径下文件夹的大小
 *
 *  @param folderPath 文件夹路劲
 *
 *  @return 返回文件大小
 */
+(float )folderSizeAtPath:(NSString*)folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


/**
 *  异步清理文件夹
 *
 *  @param path     指定的文件夹路径
 *  @param complate 清理完毕后的回调block
 */
+ (void)cleanFolder:(NSString *)path complate:(void (^)(void))complate{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
@end
