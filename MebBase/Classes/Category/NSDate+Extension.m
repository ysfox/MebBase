//
//  NSDate+Extension.m
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

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

static NSDateFormatter *formatter_;

/**
 *  加载的时候自动生成一个时间格式器
 */
+ (void)load{
    formatter_ = [[NSDateFormatter alloc] init];
    [formatter_ setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Beijing"]];
    [formatter_ setDateFormat:@"yyyy-MM-dd"];
}

/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

/** 计算两时间差值 */
+ (NSDateComponents *)fromeDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *c = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    return c;
}

/**计算时间差天数 */
+ (NSString *)intervalFromLastDate:(NSString *)fromDate  toTheDate:(NSString *)toDate{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *fDate = [dateFomatter dateFromString:fromDate];
    NSDate *tDate = [dateFomatter dateFromString:toDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateCom = [calendar components:unit fromDate:fDate toDate:tDate options:0];
    return [NSString stringWithFormat:@"%ld",dateCom.day];
}





/**
 *  是否为今年
 */
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

/**
 *  是否为今天
 */
- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year
    && nowCmps.month == selfCmps.month
    && nowCmps.day == selfCmps.day;
}


/**
 *  是否为昨天
 */
- (BOOL)isYesterday{
    formatter_.dateFormat = @"yyyy-MM-dd";
    NSString *nowString = [formatter_ stringFromDate:[NSDate date]];
    NSDate *nowDate = [formatter_ dateFromString:nowString];
    NSString *selfString = [formatter_ stringFromDate:self];
    NSDate *selfDate = [formatter_ dateFromString:selfString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/**
 *  是否为明天
 */
- (BOOL)isTomorrow{
    formatter_.dateFormat = @"yyyy-MM-dd";
    NSString *nowString = [formatter_ stringFromDate:[NSDate date]];
    NSDate *nowDate = [formatter_ dateFromString:nowString];
    NSString *selfString = [formatter_ stringFromDate:self];
    NSDate *selfDate = [formatter_ dateFromString:selfString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

/**
 * 根据传入的日期计算上一天的日期，如果date为nil则返回今天的日期
 */
+ (NSDate *)preDay:(NSDate *)date{
    if (!date) {
        return [NSDate date];
    }
    NSTimeInterval interval = -60 * 60 * 24;
    return [date initWithTimeInterval:interval sinceDate:date];
}


/**
 *  根据传入的日期计算下一天的日期，如果date为nil则返回今天的日期
 */
+ (NSDate *)nextDay:(NSDate *)date{
    if (!date) {
        return [NSDate date];
    }
    NSTimeInterval interval = 60 * 60 * 24;
    return [date initWithTimeInterval:interval sinceDate:date];
}


/**
 *  获得跟当前时间（now）的差值
 */
- (NSDateComponents *)intervalToNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}


/**
 * 计算和现在的时间的字符串差值
 */
- (NSString *)intervalStrToNow{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDateComponents *cmps = [self intervalToNow];
    if ([self isThisYear]) { // 今年
        if ([self isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:self];
        } else if ([self isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            //            fmt.dateFormat = @"MM-dd HH:mm";
            fmt.dateFormat = @"yy-MM-dd";
            return [fmt stringFromDate:self];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:self];
    }
}



/**
 *  获取今天时间的日期
 */
+ (NSString *)todayDateString{
    NSDate *todayDate = [NSDate date];
    formatter_.dateFormat = @"yyyyMMdd";
    NSString *todayDateString = [formatter_ stringFromDate:todayDate];
    return todayDateString;
}


- (NSString *)dataWithFormat:(NSString *)formate{
    if(!formate.length) formate = @"yyyy-MM-dd";
    formatter_.dateFormat = formate;
    NSString *dateString = [formatter_ stringFromDate:self];
    return dateString;
    
}

/**
 * 根据传递的日期获取日期是星期几，如果date为nil则默认计算今天是星期几
 */
#pragma clang diagnostic pop
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (NSString*)weekdayFromDate:(NSDate*)inputDate{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDate * data = inputDate?inputDate:[NSDate date];
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:data];
    return [weekdays objectAtIndex:theComponents.weekday];
}



/**
 *  今日时间组件
 *
 *  @return 返回今日时间组件
 */
+(NSDateComponents *)currentDateComponent{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}



/**
 *  今天是星期几
 *
 *  @return 返回今天是星期几
 */
+(NSString *)currentWeek{
    NSDateComponents *c = [self currentDateComponent];
    NSInteger week = [c weekday];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    return [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]];
}

/**
 *  今天是哪一年
 *
 *  @return 哪一年
 */
+(NSString *)currentYear{
    NSDateComponents *c = [self currentDateComponent];
    NSInteger year=[c year];
    return [NSString stringWithFormat:@"%ld",year];
}

/**
 *  今天是哪一月
 *
 *  @return 哪一月
 */
+(NSString *)currentMonth{
    NSDateComponents *c = [self currentDateComponent];
    NSInteger month=[c month];
    return [NSString stringWithFormat:@"%ld",month];
}


/**
 *  今天是哪一日
 *
 *  @return 哪一日
 */
+(NSString *)currentDay{
    NSDateComponents *c = [self currentDateComponent];
    NSInteger day=[c day];
    return [NSString stringWithFormat:@"%ld",day];
}

+(NSString *)currentHour{
    NSDateComponents *c = [self currentDateComponent];
    NSInteger day=[c hour];
    return [NSString stringWithFormat:@"%.2ld",day];
}

+(NSString *)currentMinute{
    NSDateComponents *c = [self currentDateComponent];
    NSInteger day=[c minute];
    return [NSString stringWithFormat:@"%.2ld",day];
}



/**
 * 获取今天星期几的编号
 */
+ (NSInteger)numberOfWeek{
    NSArray *weekadys = @[@"星期天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    NSString *weekStr = [self weekdayFromDate:nil];
    return [weekadys indexOfObject:weekStr];
}


/**
 * 计算当前日期是星期几
 */
- (NSInteger)numberOfWeek{
    NSString *dateStr = [NSDate weekdayFromDate:self];
    NSArray *weekadys = @[@"星期天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    return [weekadys indexOfObject:dateStr];
}

/**
 * 获取当前时间
 */
+ (NSString *)nowTimeString{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",interval];
    return timeString;
}


/**
 * 日期转换字符串
 */
- (NSString *)stringFromDate{
    return [self stringFromDateWithFommater:@"yyyy-MM-dd HH:mm:ss"];
}



/**
 * 日期转换字符串,用指定的日期格式,如果传递空则默认为yyyy-MM-dd
 */
- (NSString *)stringFromDateWithFommater:(NSString *)fommater{
    formatter_.dateFormat = fommater?fommater:@"yyyy-MM-dd";
    NSString *dateString = [formatter_ stringFromDate:self];
    return dateString;
}


/**
 *  utc日期转换成本地日期
 */
- (NSDate *)utcDateCovertToLocalDate{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}



/**
 *  将时间戳转换为NSDate类型
 */
+(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    //    NSLog(@"传入的时间戳=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

/**
 *  将NSDate类型的时间转换为时间戳,从1970/1/1开始
 */
-(long long)getDateTimeTOMilliSeconds{
    NSTimeInterval interval = [self timeIntervalSince1970];
    //    NSLog(@"转换的时间戳=%f",interval);
    long long totalMilliseconds = interval*1000 ;
    //    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}

/**
 *  以时间为字符串加上随机值为命名
 */
+ (NSString *)getTimerandomStr{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    return timeNow;
}

@end
