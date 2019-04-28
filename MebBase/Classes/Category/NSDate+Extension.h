//
//  NSDate+Extension.h
//  AFNetworking
//
//  Created by meb on 2019/4/25.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\            **
//**********************************

#import <Foundation/Foundation.h>

@interface NSDate (Extension)


/**
 比较from和self的时间差值

 @param from 指定的一个时间对象
 @return 返回时间差值组件对象
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;


/**
 计算两时间差值

 @param fromDate 从那个时间对象点
 @param toDate 到那个时间对象点
 @return 返回时间差值组件对象
 */
+ (NSDateComponents *)fromeDate:(NSDate *)fromDate toDate:(NSDate *)toDate;


/**
 计算两时间差天数

 @param fromDate 从那个时间对象点开始
 @param toDate 到那个时间点对象结束
 @return 返回两时间差天数
 */
+ (NSString *)intervalFromLastDate:(NSString *)fromDate  toTheDate:(NSString *)toDate;


/**
 是否为今年

 @return 返回是否是今年
 */
- (BOOL)isThisYear;


/**
 是否为今天

 @return 返回是否是今天
 */
- (BOOL)isToday;


/**
 是否为昨天

 @return 返回是否是昨天
 */
- (BOOL)isYesterday;


/**
 是否为明天

 @return 返回是否是明天
 */
- (BOOL)isTomorrow;


/**
 当前当时时间组件

 @return 返回当时时间组件
 */
+(NSDateComponents *)currentDateComponent;


/**
 当前是星期几

 @return 返回当前星期几
 */
+(NSString *)currentWeek;


/**
 当前是哪一年

 @return 返回当前是哪一年
 */
+(NSString *)currentYear;


/**
 当前是哪一月

 @return 返回当前是哪一月
 */
+(NSString *)currentMonth;


/**
 当前是哪一日

 @return 返回当前是哪一日
 */
+(NSString *)currentDay;


/**
 当前小时
 
 @return 返回当前的小时
 */
+(NSString *)currentHour;


/**
 当前的分钟
 
 @return 返回当前的分钟
 */
+(NSString *)currentMinute;


/**
 根据传入的日期计算上一天的日期，如果date为nil则返回今天的日期

 @param date 传入的日期对象
 @return 返回传入日期的上一天日期
 */
+ (NSDate *)preDay:(NSDate *)date;


/**
 根据传入的日期计算下一天的日期，如果date为nil则返回今天的日期

 @param date 传入的日期对象
 @return 返回传入日期的下一天日期
 */
+ (NSDate *)nextDay:(NSDate *)date;


/**
 获得日期对象跟当前时间（now）的差值

 @return 返回日期对象和当前时间的时间组件差值
 */
- (NSDateComponents *)intervalToNow;


/**
 计算日期对象和现在的时间的字符串差值

 @return 返回计算的时间差值字符串
 */
- (NSString *)intervalStrToNow;


/**
 获取今天时间的日期

 @return 返回今天的时间字符串
 */
+ (NSString *)todayDateString;


/**
 以指定格式获取今天日的日期字符串

 @param formate 指定的日期格式
 @return 返回今天的s日期格式
 */
- (NSString *)dataWithFormat:(NSString *)formate;


/**
 根据传递的日期获取日期是星期几，如果date为nil则默认计算今天是星期几

 @param inputDate 传递的日期对象
 @return 返回传递日期是星期几
 */
+ (NSString*)weekdayFromDate:(NSDate*)inputDate;


/**
 获取今天星期几的编号(比如星期天的编号是0)

 @return 返回今天是星期几的编号
 */
+ (NSInteger)numberOfWeek;


/**
  计算当前日期是星期几

 @return 返回当前日期是星期几
 */
- (NSInteger)numberOfWeek;


/**
 获取当前时间

 @return 返回当前时间
 */
+ (NSString *)nowTimeString;


/**
 将日期对象转换字符串

 @return 返回转换后的字符串
 */
- (NSString *)stringFromDate;


/**
 用指定的日期格式将日期转换成字符串,,如果日期格式传递空则默认为yyyy-MM-dd

 @param fommater 指定的日期格式
 @return 返回转换后的字符串
 */
- (NSString *)stringFromDateWithFommater:(NSString *)fommater;


/**
 将当前UTC日期转换成本地日期

 @return 返回转换好的时间日期对象
 */
- (NSDate *)utcDateCovertToLocalDate;


/**
 将指定的时间戳转换为NSDate时间对象

 @param miliSeconds 指定的时间戳
 @return 返回转换后的NSDate对象
 */
+(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds;


/**
 将从1970/1/1开始到现在的NSDate类型的时间转换为时间戳

 @return 返回转换后的时间戳
 */
-(long long)getDateTimeTOMilliSeconds;


/**
 以时间为字符串加上随机值为命名

 @return 返回以时间为字符串加上随机值的字符串
 */
+ (NSString *)getTimerandomStr;

@end

