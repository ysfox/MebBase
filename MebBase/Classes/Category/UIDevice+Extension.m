//
//  UIDevice+Extension.m
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

#import "UIDevice+Extension.h"
#import <sys/utsname.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "mach/mach.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <AudioToolbox/AudioToolbox.h>

/**
 *  已经使用了内存
 *
 *  @return 返回已经使用的存储
 */
vm_size_t usedMemory(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}


/**
 *  可使用的内存空间
 *
 *  @return 返回可使用的内存空间
 */
vm_size_t freeMemory(void) {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}


@implementation UIDevice (Extension)

/**
 *  获取硬件设备的名字
 *
 *  @return 返回设备的名称
 */
NSString* deviceName(){
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}


/**
 *  另外一种获取引荐设备名称的方法
 *
 *  @return 返回阴茎癌设备的名称
 */
+(NSString *)hardwareString{
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}


/**
 *  获取设备的名称
 *
 *  @return 返回设备的名称
 */
+(NSString *)deviceString{
    NSString *hardware = deviceName();
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([hardware isEqualToString:@"iPhone8,1"])    return @"iPhone 6s Plus";
    if ([hardware isEqualToString:@"iPhone8,2"])    return @"iPhone 6s";
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([hardware isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([hardware isEqualToString:@"iPad6,8"])      return @"iPad Pro";
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    return hardware;
}



/**
 *  根据手机高度来判断是否哪一类手机
 *
 *  @return 返回手机高度相同的类型
 */
+(CFDevieceHightType)dviveTypeByHeiht{
    if ([[self deviceString] containsString:@"iPhone 4"]) {
        return CFDevieceHight4;
    }
    if ([[self deviceString] containsString:@"iPhone 5"]) {
        return CFDevieceHight5;
    }
    if ([[self deviceString] isEqualToString:@"iPhone 6"] || [[self deviceString] isEqualToString:@"iPhone 6s"]) {
        return CFDevieceHight6;
    }
    if ([[self deviceString] isEqualToString:@"iPhone 6 Plus"] || [[self deviceString] isEqualToString:@"iPhone 6s Plus"]) {
        return CFDevieceHight6P;
    }
    return -1;
}


/**
 *  当前设备的屏幕尺寸的判别
 *
 *  @return 返回当前手机屏幕的尺寸的判别
 */
+(CGFloat)currentDviveScreenMeasure{
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat diviceScreen = 3.5f;
    if ((568 == screen_height && 320 == screen_width) || (1136 == screen_height && 640 == screen_width)) {
        diviceScreen = 4.0;
    } else if ((667 == screen_height && 375 == screen_width) || (1334 == screen_height && 750 == screen_width)) {
        diviceScreen = 4.7;
    } else if ((736 == screen_height && 414 == screen_width) || (2208 == screen_height && 1242 == screen_width)) {
        diviceScreen = 5.5;
    }
    
    return diviceScreen;
}

/**
 *  是否是Retina屏幕
 *
 *  @return 返回是否是retina屏幕
 */
+(BOOL)isRetina{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&([UIScreen mainScreen].scale == 2.0)){
        return YES;
    }else{
        return NO;
    }
}


/**
 *  判断当前系统版本是否是最新版本
 *
 *  @param version 当前的系统版本
 *
 *  @return 但会是否是最新
 */
- (BOOL)isLeastVersion:(NSString *)version{
    NSComparisonResult result = [[self systemVersion] compare:version options:NSNumericSearch];
    return (result == NSOrderedDescending || result == NSOrderedSame);
}


/**
 *  获取版本代码
 *
 *  @return 返回版本代码
 */
+(NSString *)getVersionCode{
    struct utsname systemInfo;
    uname(&systemInfo);
    //获取到版本号码
    NSString *versionCode = [NSString stringWithUTF8String:[[[NSString alloc]initWithBytes:&systemInfo length:_SYS_NAMELEN encoding:NSASCIIStringEncoding] UTF8String]];
    return versionCode;
}


/**
 *  根据方向计算合适的旋转仿射矩阵
 *
 *  @param orientation 方向
 *
 *  @return 返回仿射矩阵
 */
+ (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    // calculate a rotation transform that matches the required orientation
    if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        transform = CGAffineTransformMakeRotation(M_PI);
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight) {
        transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    
    return transform;
}



/**
 *  获取到设备的类型
 *
 *  @return 返回设备的类型
 */
+(CFDevieceType)getType{
    NSString *versionCode = [UIDevice getVersionCode];
    if (
        [versionCode isEqualToString:@"iPhone3,1"]
        ||[versionCode isEqualToString:@"iPhone3,2"]
        ||[versionCode isEqualToString:@"iPhone3,3"]
        ||[versionCode isEqualToString:@"iPhone4,1"]
        ||[versionCode isEqualToString:@"iPhone4,2"]
        ||[versionCode isEqualToString:@"iPhone4,3"]
        ||[versionCode isEqualToString:@"iPhone5,1"]
        ||[versionCode isEqualToString:@"iPhone5,2"]
        ||[versionCode isEqualToString:@"iPhone5,3"]
        ||[versionCode isEqualToString:@"iPhone5,4"]
        ||[versionCode isEqualToString:@"iPhone6,1"]
        ||[versionCode isEqualToString:@"iPhone6,2"]
        ||[versionCode isEqualToString:@"iPhone7,1"]
        ||[versionCode isEqualToString:@"iPhone7,2"]
        ||[versionCode isEqualToString:@"iPhone8,1"]
        ||[versionCode isEqualToString:@"iPhone8,1"]) {
        return CFDevieceiPhone;
    }else if (
              [versionCode isEqualToString:@"iPad1,1"]
              ||[versionCode isEqualToString:@"iPad2,1"]
              ||[versionCode isEqualToString:@"iPad2,2"]
              ||[versionCode isEqualToString:@"iPad2,3"]
              ||[versionCode isEqualToString:@"iPad2,4"]
              ||[versionCode isEqualToString:@"iPad2,5"]
              ||[versionCode isEqualToString:@"iPad2,6"]
              ||[versionCode isEqualToString:@"iPad2,7"]
              ||[versionCode isEqualToString:@"iPad3,1"]
              ||[versionCode isEqualToString:@"iPad3,2"]
              ||[versionCode isEqualToString:@"iPad3,3"]
              ||[versionCode isEqualToString:@"iPad3,4"]
              ||[versionCode isEqualToString:@"iPad3,5"]
              ||[versionCode isEqualToString:@"iPad3,6"]
              ||[versionCode isEqualToString:@"iPad4,1"]
              ||[versionCode isEqualToString:@"iPad4,2"]
              ||[versionCode isEqualToString:@"iPad4,3"]
              ||[versionCode isEqualToString:@"iPad4,4"]
              ||[versionCode isEqualToString:@"iPad4,5"]
              ||[versionCode isEqualToString:@"iPad4,6"]
              ||[versionCode isEqualToString:@"iPad4,7"]
              ||[versionCode isEqualToString:@"iPad4,8"]
              ||[versionCode isEqualToString:@"iPad4,9"]
              ||[versionCode isEqualToString:@"iPad5,1"]
              ||[versionCode isEqualToString:@"iPad5,2"]
              ||[versionCode isEqualToString:@"iPad5,3"]
              ||[versionCode isEqualToString:@"iPad5,4"]
              ||[versionCode isEqualToString:@"iPad6,7"]
              ||[versionCode isEqualToString:@"iPad6,8"]){
        return CFDevieceiPad;
    }else if (
              [versionCode isEqualToString:@"iPod1,1"]
              ||[versionCode isEqualToString:@"iPod2,1"]
              ||[versionCode isEqualToString:@"iPod3,1"]
              ||[versionCode isEqualToString:@"iPod4,1"]
              ||[versionCode isEqualToString:@"iPod5,1"]
              ||[versionCode isEqualToString:@"iPod7,1"]){
        return CFDevieceiPod;
    }else if (
              [versionCode isEqualToString:@"i386"]
              ||[versionCode isEqualToString:@"x86_64"]){
        return CFDevieceSimulator;
    }else{
        return CFDevieceUnknown;
    }
}


/**
 *  获取到设备的尺寸
 *
 *  @return 返回设备的尺寸
 */
+(CFDevieceSize)getSize{
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenHeight = MAX(screen_width, screen_height);
    if (480 == screenHeight) {
        return CFDevieceScreen3_5Inch;
    } else if (568 == screenHeight){
        return CFDevieceScreen4Inch;
    } else if (667 == screenHeight){
        return ([[UIScreen mainScreen] scale] == 3.0)?CFDevieceScreen5_5Inch : CFDevieceScreen4_7Inch;
    } else if (763 == screenHeight){
        return CFDevieceScreen5_5Inch;
    }else{
        return CFDevieceUnknownSize;
    }
}


/**
 *  拼接原数据
 *
 *  @return 拼接原数据
 */
+(NSString *)packageMetaInfo{
    return @"";
}


/**
 *  获取ssid信息
 *
 *  @return 返回获取到的ssid信息
 */
+ (id)fetchSSIDInfo{
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    NSDictionary *info;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}



#pragma mark - other
/**
 *  获取设备的唯一标示
 *
 *  @return 返回设备的唯一标示
 */
+(NSString *)uniqueidentifier{
    return [NSUUID UUID].UUIDString;
}


/**
 *  当前设备的名字
 *
 *  @return 返回当前设备的名字
 */
+(NSString *)deviceName{
    return [UIDevice currentDevice].name;
}


/**
 *  当前设备的系统名称，例如"iPhone OS"
 *
 *  @return 返回当前设备的系统名字
 */
+(NSString *)deviceSystemName{
    return [UIDevice currentDevice].systemName;
}


/**
 *  当前设别的系统的版本，例如"8.0"
 *
 *  @return 返回当前设备的系统版本
 */
+(NSString *)deviceSystemVersion{
    return [UIDevice currentDevice].systemVersion;
}


#pragma mark - UIScreen

/**
 *  当前设备的尺寸
 *
 *  @return 返回当前设备的尺寸
 */
+(CGSize)deviceScreenSize{
    return [[UIScreen mainScreen] bounds].size;
}


/**
 *  获取当前设备的缩放比例，如果是如果是普通屏幕则是1.0，如果是retania则是2.0
 *
 *  @return 返回设备的缩放比例
 */
+(CGFloat)deviceScreenScale{
    return [UIScreen mainScreen].scale;
}

/**
 *  设置屏幕亮度
 *
 *  @param level 设置屏幕亮度等级，等级从0.0~1.0
 */
+(void)setScreenBright:(CGFloat)level{
    [[UIScreen mainScreen] setBrightness:level];
}


/**
 *  获取当前设备屏幕的快照
 *
 *  @return 返回快照视图
 */
+(UIView *)snapshotCurrentScreen{
    return [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
}



/**
 *  打电话
 *
 *  @param phoneNumber 电话号码
 */
+(void)callPhone:(NSString *)phoneNumber{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow.rootViewController.view addSubview:callWebview];
    
}

/**
 *  手机代理器商
 */
+(NSString *)userAgentMobile{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    return [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
}

/**
 *  获取用户wifi名称
 *
 *  @return 返回用户wifi名称
 */
+(NSString *)userWifiName{
    NSString *wifi = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifi = [dict valueForKey:@"SSID"];
        }
    }
    return wifi;
}


/**
 *  获取用户的UUID
 *
 *  @return 返回用户的UUID串号
 */
+(NSString *)userUUID{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


/**
 *  获取用户IP地址
 *
 *  @return 返回用户ip地址
 */
+(NSString *)userIPAdress{
    NSString *address = @"Not Found";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

/**
 *  强制旋转设备
 *  @param  orientation 旋转方向
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[self currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}


/**
 *  震动设备
 */
+ (void)vibrateDevice{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


/**
 *  播放系统声音
 */
+ (void)playSystemSound{
    AudioServicesPlaySystemSound(1009);
}


@end
