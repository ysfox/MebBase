//
//  NSString+Extension.h
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

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  判断字符串是否nil或者是否为空
 *
 *  @param str 字符串
 *
 *  @return 返回判断结果标记
 */
+ (BOOL)isNilOrEmpty:(NSString *)str;
    
/**
 *  判断字符串是否为空
 *
 *  @return 返回判断结果
 */
- (BOOL)isBlankString;
    
    
/**
 *  判断字符串中是否包含中文字符
 *
 *  @return 返回判断结果标记
 */
- (BOOL)isIncludeChineseInString;
    
/**
 *  去掉字符串前后的空白
 *
 *  @return 返回去掉空白之后的字符串
 */
- (NSString *)trimWhitespace;
    
    
/**
 *  去掉首尾空白和换行
 *
 *  @return 返回字符串
 */
- (NSString *)trimWhitespaceAndShift;
    
/**
 *  获取字符串中的数字部分
 *
 *  @return 返回字符串中的数字部分
 */
- (NSString *)getNumString;
    
/**
 *  过滤HTML
 *
 *  @return 返回过滤后的字符串
 */
- (NSString *)removeHtml;
    
#pragma mark - 获取尺寸和行数
    
/**
 *  获取当前字符串的行数
 *
 *  @return 返回当前字符串的行数
 */
- (NSUInteger)numberOfLines;
    
    
    
/**
 *  根据文字计算尺寸
 *
 *  @param font 文字的字体
 *
 *  @return 返回计算的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font;
    
    
/**
 *  根据文字计算尺寸
 *
 *  @param font 文字的字体
 *  @param maxW 给定的最大宽度
 *
 *  @return 返回计算的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
    
    
/**
 *  根据文字计算尺寸
 *
 *  @param font 文字字体
 *  @param size 给定的最大尺寸
 *
 *  @return 返回尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxS:(CGSize)size;
    
    
/**
 *  根据传递的属性计算文件的尺寸
 *
 *  @param attrs 属性
 *  @param maxW  最大宽度
 *
 *  @return 返回计算的尺寸
 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs maxW:(CGFloat)maxW;
    
    
#pragma mark - 获取文件大小
    
/**
 *  获得文件大小，以数字的形式返回
 *
 *  @return 获得字符串形式的文件大小
 */
- (NSInteger)fileSize;
    
    
/**
 *  获得文件大小，以字符串的形式返回
 *
 *  @return 获得字符串形式的文件大小
 */
- (NSString *)fileSizeString;
    
    
#pragma mark - 字符串加密
/** md5加密get方法 */
@property (readonly) NSString *md5String;
/** sha1加密get方法 */
@property (readonly) NSString *sha1String;
/** sha256加密get方法 */
@property (readonly) NSString *sha256String;
/** sha512加密get方法 */
@property (readonly) NSString *sha512String;
    
/**
 *  sha1加盐加密
 *
 *  @param key 加盐关键字
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha1StringWithKey:(NSString *)key;


/**
 *  hmacSha1加盐加密
 *
 *  @param key 加盐关键字
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)hmacSha1WithKey:(NSString *)key;
    
/**
 *  sha256加盐加密
 *
 *  @param key 加盐关键字
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha256StringWithKey:(NSString *)key;
    
/**
 *  sha512加盐加密
 *
 *  @param key 加盐关键字
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha512StringWithKey:(NSString *)key;
    
    
#pragma mark - 其它
/**
 *  判断字符串是否为纯数字
 *
 *  @return 返回判断结果
 */
- (BOOL)isPureInt;
    
/**
 *  用户名是否合法，要求用户名必须大于3位小于20位
 *
 *  @return 返回用户名是否合法
 */
- (BOOL)isUserName;
    
/**
 *  密码是否和做法，要求密码大于6位小于20位
 *
 *  @return 返回密码是否合法
 */
- (BOOL)isPassword;
    
/**
 *  电话号码是否合法
 *
 *  @return 返回电话号码是否合法
 */
- (BOOL)isTelephone;
    
/**
 *  邮箱地址是否合法
 *
 *  @return 返回是否合法
 */
- (BOOL)isEmail;
    
    
/**
 *  url是否合法
 *
 *  @return 返回url是否合法
 */
- (BOOL)isUrl;
    
    
/**
 *  验证是身份证是否有效
 *
 *  @return 返回是否身份证是否有效
 */
- (BOOL)isIdentityCard;
    
/**
 *  验证是否是合法的车牌号码
 *
 *  @return 返回是否合法的车牌号码
 */
+ (BOOL)isCarLicence;
    
/**
 *  验证是否是日期格式
 *
 *  @return 返回是否是日期格式
 */
- (BOOL)isDate;
    
    
/**
 *  验证是否是时间
 *
 *  @return 返回是否是时间格式
 */
- (BOOL)isTime;
    
    
#pragma mark - 谓词方式验证
/**
 *  谓词方式验证是否是手机号码
 *
 *  @dis 验证范围比对
 *          移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 *          联通：130,131,132,152,155,156,185,186
 *          电信：133,1349,153,180,189,181
 *
 *  @return 返回是否是手机号码结果
 */
- (BOOL)isMobileNumer;
    
    
/**
 *  谓词的方式验证是否是合法的邮箱地址
 *
 *  @return 返回是否是有效邮箱
 */
- (BOOL)isValidEmail;
    
    
/**
 *  谓词的方式验证是否是合法的身份证号码
 *
 *  @return 返回是否是有效的身份证号码
 */
- (BOOL)isValidIdentityNumber;
    
    
#pragma mark - 其它方法
    
/**
 *  数字NSNumber转换成字符串
 *
 *  @param number 传递的数字
 *
 *  @return 返回字符串
 */
+ (NSString *)stringFromNumber:(id)number;
    
/**
 *  字符串转换成日期格式
 *
 *  @return 返回转换的日期格式，如果字符串的格式不是时间格式，则返回nil
 */
- (NSDate *)stringToDate;
    
    
/**
 *  获取到字符串中的最后一位的数字(要求最后字符串必须是数字字符串)
 *
 *  @param index 索引位置
 *
 *  @return 返回获取到的数字
 */
- (NSUInteger)numberIndex:(NSUInteger)index;


/**
 获取指定长度的随机字符串

 @param len 指定长度
 @return 返回随机字符串
 */
+ (NSString *)randomStringWithLength:(NSInteger)len;


/**
  获取指定长度的随机数字字符串

 @param len 指定长度
 @return 返回随机数字字符串
 */
+ (NSString *)randomNumberStringWithLength:(NSInteger)len;
    
    
#pragma mark - 沙盒路径拼接
/**
 *  创建一个cache目录
 *
 *  @return 返回拼接之后的cache文件路径
 */
-(NSString *)cacheDir;
    
/**
 *  创建一个ducument路劲
 *
 *  @return 返回拼接之后的dument文件路径
 */
-(NSString *)documentDir;
    
/**
 *  创建一个temp路径
 *
 *  @return 返回拼接之后的temp文件路径
 */
-(NSString *)tempDir;
    

/**
 *  指定路劲下文件是否存在
 *
 *  @return 返回文件是否存在
 */
-(BOOL)fileExist;
    
    
/**
 *  获取下载图片的路劲
 *
 *  @return 返回下载图片的路劲
 */
-(NSString *)getDownloadImagePath;
    
    
/**
 *  创建文件夹，如果文件夹不存在
 *
 *  @return 返回是否创建成功
 */
-(BOOL)folderCreate;
    
    
/**
 *  是否有俄文字符
 *
 *  @return 返回是否有俄文字符
 */
- (BOOL)hasRussianCharacters;
    
    
/**
 *  是否有英文字符
 *
 *  @return 返回是否有英文字符
 */
- (BOOL)hasEnglishCharacters;
    
    
/**
 *  获取到自定子类字符串的范围对象(忽略大小写)
 *
 *  @param s 自定的子类字符串
 *
 *  @return 返回查找到的范围
 */
-(NSRange)rangeOfStringNoCase:(NSString*)s;
    
    
/**
 *  返回字符串中数组范文
 *
 *  @return 返回查找到的范围
 */
-(NSRange)rangeOfNumbers;
    
    
#pragma mark - Search
/**
 *  通过给定的搜索关键字查询关键字在字符串中的范围
 *
 *  @param searchString 搜索关键字
 *  @param mask         搜索方式
 *  @param range        搜索范围
 *
 *  @return 返回查找到的范围数组
 */
- (NSArray *)rangesOfString:(NSString *)searchString
                    options:(NSStringCompareOptions)mask
                serachRange:(NSRange)range;
    
#pragma mark - 时间处理
+ (NSString *)timeIntervalToMMSSFormat:(NSTimeInterval)interval;
+ (NSString*)timeStringForTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)timeFormatted:(NSInteger)totalSeconds;
+ (NSInteger)secondFromTime:(NSString *)time;

@end

