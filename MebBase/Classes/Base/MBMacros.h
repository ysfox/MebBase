//
//  MBMacros.h
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

#ifndef Constant_h
#define Constant_h

//应用代理
#define MEAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

//屏幕尺寸宏定义
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([UIScreen mainScreen].bounds.size)
#define SCEEEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_SCALE ([UIScreen mainScreen].scale)

//横竖屏幕判断
#define SCREEN_LANSCAPE (SCREEN_WIDTH>SCREEN_HEIGHT)
#define SCREEN_PORTRAIT (!SCREEN_LANSCAPE)

//导航尺寸
#define NAVBAR_HEIGHT 44
#define STATUSBAR_HEIGHT 20
#define TABBAR_HEIGHT 49

//设备
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])
#define iPhone4_4s     (SCREEN_WIDTH == 320.f && SCREEN_HEIGHT == 480.f ? YES : NO)
#define iPhone5_5s     (SCREEN_WIDTH == 320.f && SCREEN_HEIGHT == 568.f ? YES : NO)
#define iPhone6_6s     (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 667.f ? YES : NO)
#define iPhone6_6sPlus (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 736.f ? YES : NO)

//系统版本
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBAFCOLOR(fr,fg,fb,a) [UIColor colorWithRed:(fr) green:(fg) blue:(fb) alpha:(a)]
#define RGBCOLOR(r,g,b) RGBACOLOR(r,g,b,1.0f)
#define RANDOMCOLOR [UIColor colorWithHue:(arc4random()%256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()%128/256.0)+0.5 alpha:1]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ALPHACOLOR(c,a) [c colorWithAlphaComponent:a]

//应用主题颜色
#define APP_THEME_COLOR RGBCOLOR(230,51,55)
#define APP_THEME_REVERSE_COLOR RGBCOLOR(41,81,141)
//应用背景颜色
#define APP_BACKGROUND_COLOR RGBCOLOR(245,245,245)



//获取应用显示的名称
#define kAppDisplayName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//获取应用的BundleId
#define kAppBundleIdentifier [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
//获取应用的版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//沙盒Cache路径
#define CFCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
//沙盒Document路径
#define CFDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//沙盒Temp路径
#define CFTempPath NSTemporaryDirectory()


//弱引用
#define CFWeakSelf __weak typeof(self) weakSelf = self;
//强引用
#define CFStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

//通知中心
#define CFNotificationCenter [NSNotificationCenter defaultCenter]
//偏好设置
#define CFUserDefaults [NSUserDefaults standardUserDefaults]


//Debug宏定义
#ifdef DEBUG
#define CFLog(...) NSLog(__VA_ARGS__)
#define CFLogFunc  NSLog(@"%s", __func__)
#else
#define CFLog(...)
#define CFLogFunc
#endif

//打印当前方法的名称
#define CFMethodName() CFPrint(@"%s", __PRETTY_FUNCTION__)
#ifdef ITTDEBUG
#define CFPrint(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define CFPrint(xx, ...)  ((void)0)
#endif

//由角度获取弧度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
//由弧度获取角度
#define radianToDegrees(radian) (radian*180.0)/(M_PI)


//单例.h文件
#define CFSingletonH(name) + (instancetype)shared##name;

//单例.m文件
#define CFSingletonM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

//应用的AppleID
#define kApplicationAppleID @"1192686263"

//Thrift的IP和端口
#define kThriftDomain @"47.101.220.24"
#define kThriftPort 9090

#endif /* Constant_h */
