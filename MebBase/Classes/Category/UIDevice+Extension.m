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
#import "mach/mach.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AdSupport/AdSupport.h>
#import <sys/socket.h>
#import <net/if.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>
#import <sys/mount.h>
#import <mach/vm_statistics.h>
#import <mach/message.h>
#import <mach/mach_host.h>
#import <netdb.h>
#import <ifaddrs.h>
#import <dlfcn.h>
#import <resolv.h>
#import "sys/utsname.h"
#import <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>

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
    NSString *modelIdentifier = deviceName();
    if ([modelIdentifier isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([modelIdentifier isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([modelIdentifier isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([modelIdentifier isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev A)";
    if ([modelIdentifier isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([modelIdentifier isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([modelIdentifier isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([modelIdentifier isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([modelIdentifier isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([modelIdentifier isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([modelIdentifier isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([modelIdentifier isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([modelIdentifier isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([modelIdentifier isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([modelIdentifier isEqualToString:@"iPhone10,1"])   return @"iPhone 8";          // US (Verizon), China, Japan
    if ([modelIdentifier isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";     // US (Verizon), China, Japan
    if ([modelIdentifier isEqualToString:@"iPhone10,3"])   return @"iPhone X";          // US (Verizon), China, Japan
    if ([modelIdentifier isEqualToString:@"iPhone10,4"])   return @"iPhone 8";          // AT&T, Global
    if ([modelIdentifier isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";     // AT&T, Global
    if ([modelIdentifier isEqualToString:@"iPhone10,6"])   return @"iPhone X";          // AT&T, Global
    if ([modelIdentifier isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([modelIdentifier isEqualToString:@"iPhone11,4"])   return @"iPhone XSMax";
    if ([modelIdentifier isEqualToString:@"iPhone11,6"])   return @"iPhone XSMax";
    if ([modelIdentifier isEqualToString:@"iPhone10,8"])   return @"iPhone XR";
    
    
    // iPad http://theiphonewiki.com/wiki/IPad
    
    if ([modelIdentifier isEqualToString:@"iPad1,1"])      return @"iPad 1G";
    if ([modelIdentifier isEqualToString:@"iPad2,1"])      return @"iPad 2 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPad2,4"])      return @"iPad 2 (Rev A)";
    if ([modelIdentifier isEqualToString:@"iPad3,1"])      return @"iPad 3 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([modelIdentifier isEqualToString:@"iPad3,4"])      return @"iPad 4 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    if ([modelIdentifier isEqualToString:@"iPad6,11"])     return @"iPad (5th gen) (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad6,12"])     return @"iPad (5th gen) (Cellular)";
    
    if ([modelIdentifier isEqualToString:@"iPad4,1"])      return @"iPad Air (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    
    if ([modelIdentifier isEqualToString:@"iPad2,5"])      return @"iPad mini 1G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad2,6"])      return @"iPad mini 1G (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,7"])      return @"iPad mini 1G (Global)";
    if ([modelIdentifier isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad4,6"])      return @"iPad mini 2G (Cellular)"; // TD-LTE model see https://support.apple.com/en-us/HT201471#iPad-mini2
    if ([modelIdentifier isEqualToString:@"iPad4,7"])      return @"iPad mini 3G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad4,8"])      return @"iPad mini 3G (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad4,9"])      return @"iPad mini 3G (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad5,1"])      return @"iPad mini 4G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad5,2"])      return @"iPad mini 4G (Cellular)";
    
    // iPad Pro https://www.theiphonewiki.com/wiki/IPad_Pro
    
    if ([modelIdentifier isEqualToString:@"iPad6,3"])      return @"iPad Pro (9.7 inch) 1G (Wi-Fi)"; // http://pdadb.net/index.php?m=specs&id=9938&c=apple_ipad_pro_9.7-inch_a1673_wifi_32gb_apple_ipad_6,3
    if ([modelIdentifier isEqualToString:@"iPad6,4"])      return @"iPad Pro (9.7 inch) 1G (Cellular)"; // http://pdadb.net/index.php?m=specs&id=9981&c=apple_ipad_pro_9.7-inch_a1675_td-lte_32gb_apple_ipad_6,4
    if ([modelIdentifier isEqualToString:@"iPad6,7"])      return @"iPad Pro (12.9 inch) 1G (Wi-Fi)"; // http://pdadb.net/index.php?m=specs&id=8960&c=apple_ipad_pro_wifi_a1584_128gb
    if ([modelIdentifier isEqualToString:@"iPad6,8"])      return @"iPad Pro (12.9 inch) 1G (Cellular)"; // http://pdadb.net/index.php?m=specs&id=8965&c=apple_ipad_pro_td-lte_a1652_32gb_apple_ipad_6,8
    if ([modelIdentifier isEqualToString:@"iPad7,1"])     return @"iPad Pro (12.9 inch) 2G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad7,2"])     return @"iPad Pro (12.9 inch) 2G (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad7,3"])     return @"iPad Pro (10.5 inch) 1G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad7,4"])     return @"iPad Pro (10.5 inch) 1G (Cellular)";
    
    // iPod http://theiphonewiki.com/wiki/IPod
    
    if ([modelIdentifier isEqualToString:@"iPod1,1"])      return @"iPod touch 1G";
    if ([modelIdentifier isEqualToString:@"iPod2,1"])      return @"iPod touch 2G";
    if ([modelIdentifier isEqualToString:@"iPod3,1"])      return @"iPod touch 3G";
    if ([modelIdentifier isEqualToString:@"iPod4,1"])      return @"iPod touch 4G";
    if ([modelIdentifier isEqualToString:@"iPod5,1"])      return @"iPod touch 5G";
    if ([modelIdentifier isEqualToString:@"iPod7,1"])      return @"iPod touch 6G"; // as 6,1 was never released 7,1 is actually 6th generation
    
    // Apple TV https://www.theiphonewiki.com/wiki/Apple_TV
    
    if ([modelIdentifier isEqualToString:@"AppleTV1,1"])      return @"Apple TV 1G";
    if ([modelIdentifier isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2G";
    if ([modelIdentifier isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3G";
    if ([modelIdentifier isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3G"; // small, incremental update over 3,1
    if ([modelIdentifier isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4G"; // as 4,1 was never released, 5,1 is actually 4th generation
    
    // Simulator
    if ([modelIdentifier hasSuffix:@"86"] || [modelIdentifier isEqual:@"x86_64"]){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        NSInteger screenHeight = ((NSInteger)screenRect.size.height > (NSInteger)screenRect.size.width) ? (NSInteger)screenRect.size.height : (NSInteger)screenRect.size.width;
        
        switch (screenHeight) {
            case 480:
            case 568:
            case 667:
            case 736:
            case 812:
            case 896:{
                return @"iPhone Simulator";
                break;
            }
                break;
            case 1024:
            case 1366:{
                return @"iPad Simulator";
                break;
            }
            default:{
                return @"";
                break;
            }
        }
    }
    
    return modelIdentifier;
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
 *  获取到设备的类型
 *
 *  @return 返回设备的类型
 */
+(CFDeviceType)getType{
    NSString *versionCode = [UIDevice getVersionCode];
    if ([versionCode containsString:@"iPhone"]) {
        return CFDeviceiPhone;
    }else if ([versionCode containsString:@"iPad"]){
        return CFDeviceiPad;
    }else if ([versionCode containsString:@"iPod"]){
        return CFDeviceiPod;
    }else if ([versionCode containsString:@"AppleTV"]){
        return CFDeviceAppleTV;
    }else if ([versionCode isEqualToString:@"i386"]||[versionCode isEqualToString:@"x86_64"]){
        return CFDeviceSimulator;
    }else{
        return CFDeviceUnknown;
    }
}


/**
 *  获取到设备的尺寸
 *
 *  @return 返回设备的尺寸
 */
+(CFDeviceScreenInch)getSize{
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenHeight = MAX(screen_width, screen_height);
    if (480 == screenHeight) {
        return CFDeviceScreen3_5Inch;
    } else if (568 == screenHeight){
        return CFDeviceScreen4Inch;
    } else if (667 == screenHeight){
        return ([[UIScreen mainScreen] scale] == 3.0)?CFDeviceScreen5_5Inch : CFDeviceScreen4_7Inch;
    } else if (763 == screenHeight){
        return CFDeviceScreen5_5Inch;
    }else{
        return CFDeviceUnknownSize;
    }
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



+ (NSTimeInterval)getAppLaunchedCurrentTimestamp{
    
    NSDate * currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    
    return [currentDate timeIntervalSince1970] * 1000;
    
}


+ (NSString *)getAppTimestampString{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[self class] getAppLaunchedCurrentTimestamp]/ 1000.0];
    return [formatter stringFromDate:date];
    
}

+ (NSString *)getAppDisplayName{
    
    return appInfoDictionary()[@"CFBundleDisplayName"];
}

+ (NSString *)getAppVersion{
    
    return appInfoDictionary()[@"CFBundleShortVersionString"];
}

+ (NSString *)getPhoneSystemVersion{
    
    return [currentDevice() systemVersion];
    
}

+ (NSString *)getPhoneSystemName{
    
    return [currentDevice() systemName];
}

+ (NSString *)getSystemPreferredLanguage{
    
    return [NSLocale preferredLanguages][0];
    
}

+ (NSString *)getPhoneModel{
    
    return [currentDevice() model];
}

+ (NSString *)getAdvertisingIdentifier{
    
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
}

+ (NSString *)getIdentifierForVendor{
    return [[currentDevice() identifierForVendor] UUIDString];
}

+ (NSString *)getTelephonyCarrier{
    
    CTTelephonyNetworkInfo * networkInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier * carrier = [networkInfo subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        return @"没有SIM卡--无运营商";
    }
    
    return [carrier carrierName];
    
}

+ (NSString *)getMobileCountryCode{
    
    CTTelephonyNetworkInfo * networkInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier * carrier = [networkInfo subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        return @"没有SIM卡--无运营商";
    }
    
    return [carrier mobileCountryCode];
    
}

+ (NSString *)getMobileNetworkCode{
    
    CTTelephonyNetworkInfo * networkInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier * carrier = [networkInfo subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        return @"没有SIM卡--无运营商";
    }
    
    return [carrier mobileNetworkCode];
    
}

// 获取电池当前的状态，共有4种状态
+ (NSString *)getBatteryState {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"UIDeviceBatteryStateUnknown";
    }else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"UIDeviceBatteryStateUnplugged";
    }else if (device.batteryState == UIDeviceBatteryStateCharging){
        if (device.batteryLevel == 1.0) {
            return @"UIDeviceBatteryStateFull";
        }
        return @"UIDeviceBatteryStateCharging";
    }else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"UIDeviceBatteryStateFull";
    } else {
        return @"uunkonw";
    }
    
}

+ (NSString *)getDeviceIpAddress{
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
    
}

+ (NSString *)getLocalWifiIpAddress{
    
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
    
}

+ (NSString *)getWifiName{
    
    NSString *wifiName = @"Not Found";
    
    CFArrayRef myArray = CNCopySupportedInterfaces();
    
    if (myArray != nil) {
        
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        
        if (myDict != nil) {
            
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            
            wifiName = [dict valueForKey:@"SSID"];
            
        }
    }
    
    return wifiName;
}

+ (long long)getTotalMemorySize{
    
    return [[NSProcessInfo processInfo] physicalMemory];
    
}
+(NSString *)getTotalMemorySizeString{
    
    return [self fileSizeToString:[self getTotalMemorySize]];
    
}

+ (long long)getAvailableMemorySize{
    
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

+(NSString *)getAvailableMemorySizeString{
    
    return [self fileSizeToString:[self getAvailableMemorySize]];
}

+ (long long)getTotalDiskSize{
    
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
    
}

+(NSString *)getTotalDiskSizeString{
    
    return [self fileSizeToString:[self getTotalDiskSize]];
}

+ (long long)getAvailableDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
    
}
+ (NSString *)getAvailableDiskSizeString{
    
    return [self fileSizeToString:[self getAvailableDiskSize]];
}

+ (BOOL)getJailbrokenDevice{
    
    BOOL jailbroken = NO;
    NSString * cydiaPath = @"/Applications/Cydia.app";
    NSString * aptPath = @"/private/var/lib/apt";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath] || [[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    return jailbroken;
}

+ (CGFloat)getBrightness{
    
    return [UIScreen mainScreen].brightness;
}


+ (NSString *)getUserDiskSizeString {
    return [self fileSizeToString:([self getTotalDiskSize] - [self getAvailableDiskSize])];
}

// 获取网络类型
+ (NSString *)getNetworkType{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    NSString *netconnType = @"";
    for (id subview in subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    netconnType = @"NONE";
                    break;
                case 1:
                    netconnType = @"2G";
                    break;
                case 2:
                    netconnType = @"3G";
                    break;
                case 3:
                    netconnType = @"4G";
                    break;
                case 5:
                    netconnType = @"WIFI";
                    break;
                default:
                    break;
            }
        }
    }
    if ([netconnType isEqualToString:@""]) {
        netconnType = @"NO DISPLAY";
    }
    return netconnType;
}

// 获取设备型号
+ (NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"国行、日版、港行iPhone 7";
    
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"港行、国行iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPhone9,3"]) return @"美版、台版iPhone 7";
    
    if ([deviceString isEqualToString:@"iPhone9,4"]) return @"美版、台版iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    return deviceString;
}

+ (NSString *)getLocalCountryCode
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}



/**
 将空间大小转化为字符串
 
 @param fileSize 空间大小
 @return 字符串
 */
+ (NSString *)fileSizeToString:(unsigned long long)fileSize
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10)
    {
        return @"0 B";
        
    }else if (fileSize < KB)
    {
        return @"< 1 KB";
        
    }else if (fileSize < MB)
    {
        return [NSString stringWithFormat:@"%.0f KB",((CGFloat)fileSize)/KB];
        
    }else if (fileSize < GB)
    {
        return [NSString stringWithFormat:@"%.0f MB",((CGFloat)fileSize)/MB];
        
    }else
    {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}





static NSString *systemBootTime(){
    struct timeval boottime;
    size_t len = sizeof(boottime);
    int mib[2] = { CTL_KERN, KERN_BOOTTIME };
    
    if( sysctl(mib, 2, &boottime, &len, NULL, 0) < 0 )
    {
        return @"";
    }
    time_t bsec = boottime.tv_sec / 10000;
    
    NSString *bootTime = [NSString stringWithFormat:@"%ld",bsec];
    
    return bootTime;
}

static NSString *countryCode() {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    return countryCode;
}

static NSString *language() {
    NSString *language;
    NSLocale *locale = [NSLocale currentLocale];
    if ([[NSLocale preferredLanguages] count] > 0) {
        language = [[NSLocale preferredLanguages]objectAtIndex:0];
    } else {
        language = [locale objectForKey:NSLocaleLanguageCode];
    }
    
    return language;
}

static NSString *systemVersion() {
    return [[UIDevice currentDevice] systemVersion];
}



static const char *SIDFAModel =       "hw.model";
static const char *SIDFAMachine =     "hw.machine";
static NSString *getSystemHardwareByName(const char *typeSpecifier) {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString *results = [NSString stringWithUTF8String:answer];
    free(answer);
    return results;
}

static NSUInteger getSysInfo(uint typeSpecifier) {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

static NSString *carrierInfo() {
    NSMutableString* cInfo = [NSMutableString string];
    
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
    NSString *carrierName = [carrier carrierName];
    if (carrierName != nil){
        [cInfo appendString:carrierName];
    }
    
    NSString *mcc = [carrier mobileCountryCode];
    if (mcc != nil){
        [cInfo appendString:mcc];
    }
    
    NSString *mnc = [carrier mobileNetworkCode];
    if (mnc != nil){
        [cInfo appendString:mnc];
    }
    
    return cInfo;
}


static NSString *systemHardwareInfo(){
    NSString *model = getSystemHardwareByName(SIDFAModel);
    NSString *machine = getSystemHardwareByName(SIDFAMachine);
    NSString *carInfo = carrierInfo();
    NSUInteger totalMemory = getSysInfo(HW_PHYSMEM);
    
    return [NSString stringWithFormat:@"%@,%@,%@,%td",model,machine,carInfo,totalMemory];
}



static NSString *systemFileTime(){
    NSFileManager *file = [NSFileManager defaultManager];
    NSDictionary *dic= [file attributesOfItemAtPath:@"System/Library/CoreServices" error:nil];
    return [NSString stringWithFormat:@"%@,%@",[dic objectForKey:NSFileCreationDate],[dic objectForKey:NSFileModificationDate]];
}

static NSString *disk(){
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSString *diskSize = [[fattributes objectForKey:NSFileSystemSize] stringValue];
    return diskSize;
}

static void MD5_16(NSString *source, unsigned char *ret){
    const char* str = [source UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    for(int i = 4; i < CC_MD5_DIGEST_LENGTH - 4; i++) {
        ret[i-4] = result[i];
    }
}

static NSString *combineTwoFingerPrint(unsigned char *fp1,unsigned char *fp2){
    NSMutableString *hash = [NSMutableString stringWithCapacity:36];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i+=1)
    {
        if (i==4 || i== 6 || i==8 || i==10)
            [hash appendString:@"-"];
        
        if (i < 8) {
            [hash appendFormat:@"%02X",fp1[i]];
        }else{
            [hash appendFormat:@"%02X",fp2[i-8]];
        }
    }
    
    return hash;
}

+ (NSString *)createSimulateIDFA{
    NSString *sysBootTime = systemBootTime();
    NSString *countryC= countryCode();
    NSString *languge = language();
    NSString *deviceN = deviceName();
    
    NSString *sysVer = systemVersion();
    NSString *systemHardware = systemHardwareInfo();
    NSString *systemFT = systemFileTime();
    NSString *diskS = disk();
    
    NSString *fingerPrintUnstablePart = [NSString stringWithFormat:@"%@,%@,%@,%@", sysBootTime, countryC, languge, deviceN];
    NSString *fingerPrintStablePart = [NSString stringWithFormat:@"%@,%@,%@,%@", sysVer, systemHardware, systemFT, diskS];
    
    unsigned char fingerPrintUnstablePartMD5[CC_MD5_DIGEST_LENGTH/2];
    MD5_16(fingerPrintUnstablePart,fingerPrintUnstablePartMD5);
    
    unsigned char fingerPrintStablePartMD5[CC_MD5_DIGEST_LENGTH/2];
    MD5_16(fingerPrintStablePart,fingerPrintStablePartMD5);
    
    NSString *simulateIDFA = combineTwoFingerPrint(fingerPrintStablePartMD5,fingerPrintUnstablePartMD5);
    return simulateIDFA;
}

@end
