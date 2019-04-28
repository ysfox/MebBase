//
//  UIDevice+Extension.h
//  AFNetworking
//
//  Created by meb on 2019/4/26.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\            **
//**********************************

#import <UIKit/UIKit.h>
//设置尺寸类型枚举，也就是同样尺寸高度的类型手机
typedef enum{
    CFDevieceHight4,            //4和4s尺寸类型手机
    CFDevieceHight5,            //5和5s尺寸类型手机
    CFDevieceHight6,            //6和6s尺寸类型手机
    CFDevieceHight6P,           //6+和6s+尺寸类型手机
    
}CFDevieceHightType;

//设备尺寸
typedef enum {
    CFDevieceUnknownSize,         //未知尺寸设备
    CFDevieceScreen3_5Inch,       //3.5英寸设备
    CFDevieceScreen4Inch,         //4.0英寸设备
    CFDevieceScreen4_7Inch,       //4.7英寸设备
    CFDevieceScreen5_5Inch,       //5.5英寸设备
}CFDevieceSize;


//设备类型
typedef enum {
    CFDevieceiPhone,                   //iPhone设备
    CFDevieceiPad,                     //iPad设备
    CFDevieceiPod,                     //iPod设备
    CFDevieceSimulator,                //Simulator设备
    CFDevieceUnknown,                  //未知设备
}CFDevieceType;

@interface UIDevice (Extension)

/**
 *  获取设备的名称
 *
 *  @return 返回设备的名称
 */
+(NSString *)deviceString;


/**
 *  根据手机高度来判断是否哪一类手机
 *
 *  @return 返回手机高度相同的类型
 */
+(CFDevieceHightType)dviveTypeByHeiht;


/**
 *  当前设备的屏幕尺寸的判别
 *
 *  @return 返回当前手机屏幕的尺寸的判别
 */
+(CGFloat)currentDviveScreenMeasure;


/**
 *  是否是Retina屏幕
 *
 *  @return 返回是否是retina屏幕
 */
+(BOOL)isRetina;

/**
 *  判断当前系统版本是否是最新版本
 *
 *  @param version 当前的系统版本
 *
 *  @return 但会是否是最新
 */
- (BOOL)isLeastVersion:(NSString *)version;


/**
 *  获取版本代码
 *
 *  @return 返回版本代码
 */
+(NSString *)getVersionCode;


/**
 *  根据方向计算合适的旋转仿射矩阵
 *
 *  @param orientation 方向
 *
 *  @return 返回仿射矩阵
 */
+ (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation;


/**
 *  获取到设备的类型
 *
 *  @return 返回设备的类型
 */
+(CFDevieceType)getType;


/**
 *  获取到设备的尺寸
 *
 *  @return 返回设备的尺寸
 */
+(CFDevieceSize)getSize;



/**
 *  拼接原数据
 *
 *  @return 拼接原数据
 */
+(NSString *)packageMetaInfo;



/**
 *  获取ssid信息
 *
 *  @return 返回获取到的ssid信息
 */
+ (id)fetchSSIDInfo;
/**
 *  打电话
 *
 *  @param phoneNumber 电话号码
 */
+(void)callPhone:(NSString *)phoneNumber;



/**
 *  手机代理器商
 */
+(NSString *)userAgentMobile;


/**
 *  获取用户wifi名称
 *
 *  @return 返回用户wifi名称
 */
+(NSString *)userWifiName;


/**
 *  获取用户的UUID
 *
 *  @return 返回用户的UUID串号
 */
+(NSString *)userUUID;


/**
 *  获取用户IP地址
 *
 *  @return 返回用户ip地址
 */
+(NSString *)userIPAdress;


/**
 *  强制旋转设备
 *  @param orientation 旋转方向
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation;


/**
 *  震动设备
 */
+ (void)vibrateDevice;


/**
 *  播放系统声音
 */
+ (void)playSystemSound;

@end
