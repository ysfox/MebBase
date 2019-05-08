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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//设备英寸
typedef enum {
    CFDeviceScreen3_5Inch,       //3.5英寸设备
    CFDeviceScreen4Inch,         //4.0英寸设备
    CFDeviceScreen4_7Inch,       //4.7英寸设备
    CFDeviceScreen5_5Inch,       //5.5英寸设备
    CFDeviceScreen5_8Inch,       //5.8英寸设备
    CFDeviceScreen6_5Inch,       //6.5英寸设备
    CFDeviceScreen7_9Inch,       //7.9英寸设备
    CFDeviceScreen9_7Inch,       //9.7英寸设备
    CFDeviceScreen10_5Inch,      //10.5英寸设备
    CFDeviceScreen12_9Inch,      //12.9英寸设备
    CFDeviceUnknownSize,         //未知尺寸设备
}CFDeviceScreenInch;


//设备类型
typedef enum {
    CFDeviceiPhone,                   //iPhone设备
    CFDeviceiPad,                     //iPad设备
    CFDeviceiPod,                     //iPod设备
    CFDeviceAppleTV,                   //AppleTv设备
    CFDeviceSimulator,                //Simulator设备
    CFDeviceUnknown,                  //未知设备
}CFDeviceType;

@interface UIDevice (Extension)

/**
 *  获取是苹果的哪一款设备
 *
 *  @return 返回设备的名称
 */
+(NSString *)deviceString;


/**
 *  获取到设备的类型
 *
 *  @return 返回设备的类型
 */
+(CFDeviceType)getType;


/**
 *  获取到设备的尺寸
 *
 *  @return 返回设备的尺寸
 */
+(CFDeviceScreenInch)getSize;



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


/**
 获取当前时间戳
 @return 返回当前时间戳
 */
+ (NSTimeInterval)getAppLaunchedCurrentTimestamp;


/**
 系统当前时间
 
 @return 当前时间:yyyy-MM-dd HH:mm
 */
+ (NSString *)getAppTimestampString;

/**
 应用名称
 
 @return 应用名称
 */
+ (NSString *)getAppDisplayName;


/**
 应用版本号
 
 @return 应用版本号
 */
+ (NSString *)getAppVersion;


/**
 系统版本号
 
 @return 系统版本号
 */
+ (NSString *)getPhoneSystemVersion;


/**
 系统名称
 
 @return 系统名称
 */
+ (NSString *)getPhoneSystemName;

/**
 系统使用语言
 
 @return 系统使用语言
 */
+ (NSString *)getSystemPreferredLanguage;

/**
 设备型号
 
 @return 手机型号
 */
+ (NSString *)getPhoneModel;

/**
 设备类型
 
 @return 设备类型(详细)
 */
+ (NSString *)getDeviceName;

/**
 电池状态
 
 @return 返回电池当前状态
 */
+ (NSString *)getBatteryState;
/**
 
 总内存大小
 
 @return 总内存大小
 */
+ (long long)getTotalMemorySize;

+ (NSString *)getTotalMemorySizeString;
/**
 手机可用内存
 
 @return  手机可用内存
 */
+ (long long)getAvailableMemorySize;
+ (NSString *)getAvailableMemorySizeString;
/**
 总磁盘容量
 
 @return 总磁盘容量
 */
+ (long long)getTotalDiskSize;
+ (NSString *)getTotalDiskSizeString;


/**
 已用空间
 
 @return 已用空间
 */
+ (NSString *)getUserDiskSizeString;

/**
 可用磁盘空间
 
 @return 可用磁盘空间
 */
+ (long long)getAvailableDiskSize;
+ (NSString *)getAvailableDiskSizeString;

// 广告位标识符
+ (NSString *)getAdvertisingIdentifier;

//由数字和字母组成的用来标识唯一设备的字符串
+ (NSString *)getIdentifierForVendor;

/**
 所在国家
 
 @return 所在国家
 */
+ (NSString *)getLocalCountryCode;
/**
 运营商
 
 @return 运营商
 */
+ (NSString *)getTelephonyCarrier;


/**
 mcc
 
 @return mcc
 */
+ (NSString *)getMobileCountryCode;

/**
 mnc
 
 @return mnc
 */
+ (NSString *)getMobileNetworkCode;

/**
 设备ip
 
 @return 设备ip
 */
+ (NSString *)getDeviceIpAddress;
/**
 网络类型
 
 @return 返回网络类型
 */
+ (NSString *)getNetworkType;
/**
 本地WiFi地址
 
 @return 本地WiFi地址
 */
+ (NSString *)getLocalWifiIpAddress;

/**
 WiFi名称
 
 @return  WiFi名称
 */
+ (NSString *)getWifiName;

/**
 是否越狱
 
 @return yes/no
 */
+ (BOOL)getJailbrokenDevice;

/**
 屏幕亮度
 
 @return 屏幕亮度
 */
+ (CGFloat)getBrightness;



/**
 获取SimulateIDFA

 @return 返回SimulateIDFA
 */
+ (NSString *)createSimulateIDFA;


@end


NS_INLINE NSDictionary * appInfoDictionary (void){
    
    return [[NSBundle mainBundle] infoDictionary];
}

NS_INLINE UIDevice * currentDevice (void){
    
    return [UIDevice currentDevice];
}
