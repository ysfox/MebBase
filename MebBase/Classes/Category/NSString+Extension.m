//
//  NSString+Extension.m
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

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Extension)
    
/**
 *  判断字符串是否nil或者是否为空
 *
 *  @param str 字符串
 *
 *  @return 返回判断结果标记
 */
+ (BOOL)isNilOrEmpty:(NSString *)str{
    if(str){
        return [str isBlankString];
    }
    
    return YES;
}
    
/**
 *  判断字符串是否为空
 *
 *  @return 返回判断结果
 */
- (BOOL)isBlankString{
    //    return [[self trimWhitespace] isEqualToString:@""] || (self == nil);
    
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
    
    
/**
 *  判断字符串中是否包含中文字符
 *
 *  @return 返回判断结果标记
 */
- (BOOL)isIncludeChineseInString{
    for (int i=0; i<self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return YES;
        }
    }
    return NO;
}
    
    
/**
 *  获取字符串中的数字部分
 *
 *  @return 返回字符串中的数字部分
 */
- (NSString *)getNumString{
    NSCharacterSet* numSet =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *numStr =[self stringByTrimmingCharactersInSet:numSet];
    return numStr;
}
    
    
/**
 *  过滤HTML
 *
 *  @return 返回过滤后的字符串
 */
- (NSString *)removeHtml{
    return [[self removeHTML:self] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
}
    
    
    
/**
 *  移除字符串中的html的第一种方法
 *
 *  @param html 含有html的字符串
 *
 *  @return 返回过滤html后的字符串
 */
- (NSString *)removeHTML:(NSString *)html {
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
    }
    return html;
}
    
    
/**
 *  过滤字符串中的html的第二种放方法
 *
 *  @param html 含有html的字符串
 *
 *  @return 返回过滤后的字符串
 */
- (NSString *)removeHTML2:(NSString *)html{
    NSArray *components = [html componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    for (int i = 0; i < [components count]; i = i + 2) {
        [componentsToKeep addObject:[components objectAtIndex:i]];
    }
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    return plainText;
}
    
    
    
/**
 *  去掉字符串前后的空白
 *
 *  @return 返回去掉空白之后的字符串
 */
- (NSString *)trimWhitespace{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}
    
    
/**
 *  去掉首尾空白和换行
 *
 *  @return 返回字符串
 */
- (NSString *)trimWhitespaceAndShift{
    NSString * headerData = self;
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return headerData;
}
    
    
#pragma mark - 获取尺寸和行数
    
/**
 *  获取当前字符串的行数
 *
 *  @return 返回当前字符串的行数
 */
- (NSUInteger)numberOfLines{
    NSUInteger lines = [self componentsSeparatedByString:@"\n"].count + 1;
    return lines;
}
    
    
/**
 *  根据文字计算尺寸
 *
 *  @param font 文字的字体
 *
 *  @return 返回计算的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
    
    
/**
 *  根据文字计算尺寸
 *
 *  @param font 文字的字体
 *  @param maxW 给定的最大宽度
 *
 *  @return 返回计算的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attrs = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
    
    
/**
 *  根据文字计算尺寸
 *
 *  @param font 文字字体
 *  @param size 给定的最大尺寸
 *
 *  @return 返回尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxS:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize = [self boundingRectWithSize:size
                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: font}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}
    
    
    
    
    
/**
 *  根据传递的属性计算文件的尺寸
 *
 *  @param attrs 属性
 *  @param maxW  最大宽度
 *
 *  @return 返回计算的尺寸
 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs maxW:(CGFloat)maxW{
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
    
    
#pragma mark - 获取文件大小
/**
 *  获得文件大小，以数字的形式返回
 *
 *  @return 获得字符串形式的文件大小
 */
- (NSInteger)fileSize{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exist = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (exist == NO) return 0;
    if (isDirectory) {
        NSInteger size = 0;
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
            if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
            size += [attrs[NSFileSize] integerValue];
        }
        return size;
    }
    return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
}
    
/**
 *  获得文件大小，以字符串的形式返回
 *
 *  @return 获得字符串形式的文件大小
 */
- (NSString *)fileSizeString{
    NSInteger fileSize = self.fileSize;
    CGFloat unit = 1000.0;
    if (fileSize >= unit * unit * unit) { // fileSize >= 1GB
        return [NSString stringWithFormat:@"%.1fGB", fileSize/(unit * unit * unit)];
    } else if (fileSize >= unit * unit) { // 1GB > fileSize >= 1MB
        return [NSString stringWithFormat:@"%.1fMB", fileSize/(unit * unit)];
    } else if (fileSize >= unit) { // 1MB > fileSize >= 1KB
        return [NSString stringWithFormat:@"%.1fKB", fileSize/ unit];
    } else { // 1KB > fileSize
        return [NSString stringWithFormat:@"%zdB", fileSize];
    }
}
    
    
#pragma mark - 字符串加密
/**
 *  md5加密get方法
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)md5String{
    if(self == nil || [self length] == 0) return nil;
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}
    
/**
 *  sha1加密get方法
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha1String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}
    
/**
 *  sha256加密get方法
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha256String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
    
/**
 *  sha512加密get方法
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha512String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}
    
/**
 *  sha1加盐加密
 *
 *  @param key 加盐关键字
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha1StringWithKey:(NSString *)key{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}
    
/**
 *  sha256加盐加密
 *
 *  @param key 加盐关键字
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha256StringWithKey:(NSString *)key{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}
    
/**
 *  sha512加盐加密
 *
 *  @param key 加盐关键字
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)sha512StringWithKey:(NSString *)key{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}
    
#pragma mark - Helpers
/**
 *  在对应字节出指定长度的数据
 *
 *  @param bytes  对应的字节处
 *  @param length 自定长度
 *
 *  @return 返回加入指定数据的字符串
 */
- (NSString *)stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
    [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}
    
    
#pragma mark - 正则验证
    
/**
 *  判断字符串是否为纯数字
 *
 *  @return 返回判断结果
 */
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
    
/**
 *  用户名是否合法，要求用户名必须大于3位小于20位
 *
 *  @return 返回用户名是否合法
 */
- (BOOL)isUserName{
    NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5_]{4,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}
    
/**
 *  密码是否和做法，要求密码大于6位小于20位
 *
 *  @return 返回密码是否合法
 */
- (BOOL)isPassword{
    NSString *regex = @"(^[A-Za-z0-9_]{6,18}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
    
    
    
/**
 *  电话号码是否合法
 *
 *  @return 返回电话号码是否合法
 */
- (BOOL)isTelephone{
    //    /**
    //     * 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189,181(增加)
    //     */
    //    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189,181(增加)
    //     22         */
    //    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:self]
    //         || [regextestcm evaluateWithObject:self]
    //         || [regextestct evaluateWithObject:self]
    //         || [regextestcu evaluateWithObject:self])) {
    //        return YES;
    //    }
    
    NSString * PH = @"^1(3[0-9]|4[5]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *regextestph = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PH];
    if([regextestph evaluateWithObject:self]){
        return YES;
    }
    
    return NO;
}
    
    

/**
 *  邮箱地址是否合法
 *
 *  @return 返回是否合法
 */
- (BOOL)isEmail{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
    
/**
 *  url是否合法
 *
 *  @return 返回url是否合法
 */
- (BOOL)isUrl{
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
    
    
/**
 *  验证是身份证是否有效
 *
 *  @return 返回是否身份证是否有效
 */
- (BOOL)isIdentityCard{
    if (self.length <= 0) return NO;
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}
    
/**
 *  验证是否是合法的车牌号码
 *
 *  @return 返回是否合法的车牌号码
 */
+ (BOOL)isCarLicence{
    NSString *regex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}
    
    
/**
 *  验证是否是日期格式
 *
 *  @return 返回是否是日期格式
 */
- (BOOL)isDate{
    NSString *regex = @"/^(d+)-(d{1,2})-(d{1,2}) (d{1,2}):(d{1,2}):(d{1,2})$/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}
    
/**
 *  验证是否是时间
 *
 *  @return 返回是否是时间格式
 */
- (BOOL)isTime{
    NSString *regex = @"/^(d{1,2}):(d{1,2}):(d{1,2})$/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}
    
    
#pragma mark - 谓词方式验证
/**
 *  谓词方式验证是否是手机号码
 *
 *  @discrip 验证范围比对
 *          移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 *          联通：130,131,132,152,155,156,185,186
 *          电信：133,1349,153,180,189,181
 *
 *  @return 返回是否是手机号码结果
 */
- (BOOL)isMobileNumer{
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:self]
         || [regextestcm evaluateWithObject:self]
         || [regextestct evaluateWithObject:self]
         || [regextestcu evaluateWithObject:self])) {
        return YES;
    }else{
        return NO;
    }
}
    
    
/**
 *  谓词的方式验证是否是合法的邮箱地址
 *
 *  @return 返回是否是有效邮箱
 */
- (BOOL)isValidEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if([emailTest evaluateWithObject:self]){
        return YES;
    }else{
        return NO;
    }
    return NO;
}
    
    
/**
 *  谓词的方式验证是否是合法的身份证号码
 *
 *  @return 返回是否是有效的身份证号码
 */
- (BOOL)isValidIdentityNumber{
    if (self.length != 18) return  NO;
    
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    
    int sumValue = 0;
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]){
        return YES;
    }
    return  NO;
}
    
    
#pragma mark - 其它方法
//TODO 这个需要扩展...要判别是否是基本数据类型还是对象类型
/**
 *  数字转换成字符串
 *
 *  @param number 传递的数字
 *
 *  @return 返回字符串
 */
+ (NSString *)stringFromNumber:(id)number{
    if (![number isKindOfClass:[NSNumber class]]) {return nil;}
    NSNumber *nb = (NSNumber *)number;
    NSString *numberStr = @"";
    CFNumberType numberType = CFNumberGetType((CFNumberRef)nb);
    switch (numberType) {
        case kCFNumberSInt8Type:
        case kCFNumberSInt16Type:
        case kCFNumberSInt32Type:
        case kCFNumberSInt64Type:
        {
            numberStr = [NSString stringWithFormat:@"%d",nb.intValue];
        }
        break;
        case kCFNumberShortType:
        {
            numberStr = [NSString stringWithFormat:@"%d",nb.shortValue];
        }
        break;
        case kCFNumberIntType:
        {
            numberStr = [NSString stringWithFormat:@"%d",nb.intValue];
        }
        break;
        case kCFNumberLongType:
        {
            numberStr = [NSString stringWithFormat:@"%ld",nb.longValue];
        }
        break;
        case kCFNumberLongLongType:
        {
            numberStr = [NSString stringWithFormat:@"%lld",nb.longLongValue];
        }
        break;
        case kCFNumberCFIndexType:
        {
            numberStr = [NSString stringWithFormat:@"%ld",(long)nb.integerValue];
        }
        break;
        case kCFNumberNSIntegerType:
        {
            numberStr = [NSString stringWithFormat:@"%lu",(unsigned long)nb.unsignedIntegerValue];
        }
        break;
        case kCFNumberFloat32Type:
        case kCFNumberFloat64Type:
        case kCFNumberFloatType:
        case kCFNumberCGFloatType:
        {
            numberStr = [NSString stringWithFormat:@"%f",nb.floatValue];
        }
        break;
        case kCFNumberDoubleType:
        {
            numberStr = [NSString stringWithFormat:@"%f",nb.doubleValue];
        }
        break;
        case kCFNumberCharType:
        {
            numberStr = [NSString stringWithFormat:@"%c",nb.charValue];
        }
        break;
        default:
        break;
    }
    
    return numberStr;
}
    
    
/**
 *  字符串转换成日期格式
 *
 *  @return 返回转换的日期格式，如果字符串的格式不是时间格式，则返回nil
 */
- (NSDate *)stringToDate{
    //    if (![self isDate]) return nil;
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    formater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formater dateFromString:self];
    return date;
}
    
    
/**
 *  获取到字符串中的最后一位的数字(要求最后字符串必须是数字字符串)
 *
 *  @param index 索引位置
 *
 *  @return 返回获取到的数字
 */
- (NSUInteger)numberIndex:(NSUInteger)index{
    NSUInteger num = [self integerValue];
    for (int i = 0; i < index; ++i) {
        num /= 10;
    }
    return num % 10;
}


/**
 获取指定长度的随机字符串
 
 @param len 指定长度
 @return 返回随机字符串
 */
+ (NSString *)randomStringWithLength:(NSInteger)len{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }
    return randomString;
}


/**
 获取指定长度的随机数字字符串
 
 @param len 指定长度
 @return 返回随机数字字符串
 */
+ (NSString *)randomNumberStringWithLength:(NSInteger)len{
    NSString *letters = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }
    return randomString;
}
    
#pragma mark - 沙盒路径拼接
/**
 *  创建一个cache目录
 *
 *  @return 返回拼接之后的cache文件路径
 */
-(NSString *)cacheDir{
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [cacheDir stringByAppendingPathComponent:self.lastPathComponent];
}
    
/**
 *  创建一个ducument路劲
 *
 *  @return 返回拼接之后的dument文件路径
 */
-(NSString *)documentDir{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documentDir stringByAppendingPathComponent:self.lastPathComponent];
}
    
/**
 *  创建一个temp路径
 *
 *  @return 返回拼接之后的temp文件路径
 */
-(NSString *)tempDir{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

    
/**
 *  指定路劲下文件是否存在
 *
 *  @return 返回文件是否存在
 */
-(BOOL)fileExist{
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}
    
    
/**
 *  获取下载图片的路劲
 *
 *  @return 返回下载图片的路劲
 */
-(NSString *)getDownloadImagePath{
    //该方法需要重写
    NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",self]];
    return path;
}
    
    
/**
 *  创建文件夹，如果文件夹不存在
 *
 *  @return 返回是否创建成功
 */
-(BOOL)folderCreate{
    BOOL isDir = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:self isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)){
        return [[NSFileManager defaultManager] createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    return NO;
}
    
    
/**
 *  是否有俄文字符
 *
 *  @return 返回是否有俄文字符
 */
- (BOOL)hasRussianCharacters{
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"];
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}
    
    
/**
 *  是否有英文字符
 *
 *  @return 返回是否有英文字符
 */
- (BOOL)hasEnglishCharacters{
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}
    
    
    
/**
 *  获取到自定子类字符串的范围对象(忽略大小写)
 *
 *  @param s 自定的子类字符串
 *
 *  @return 返回间距
 */
-(NSRange)rangeOfStringNoCase:(NSString*)s{
    return  [self rangeOfString:s options:NSCaseInsensitiveSearch];
}
    
    
    
/**
 *  返回字符串中数组范文
 *
 *  @return 返回查找到的范围
 */
-(NSRange)rangeOfNumbers{
    NSString *numStr = [self getNumString];
    return  [self rangeOfString:numStr options:NSAnchoredSearch];
}
    
    
    
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
- (NSArray *)rangesOfString:(NSString *)searchString options:(NSStringCompareOptions)mask serachRange:(NSRange)range {
    NSMutableArray *array = [NSMutableArray array];
    [self rangeOfString:searchString range:NSMakeRange(0, self.length) array:array options:mask];
    return array;
}
    
    
/**
 *  通过给定的搜索关键字查询关键字在字符串中的范围
 *
 *  @param searchString 搜索关键字
 *  @param array        数组集合
 *  @param mask         搜索方式
 *  @param searchRange  搜索范围
 *
 */
- (void)rangeOfString:(NSString *)searchString
                range:(NSRange)searchRange
                array:(NSMutableArray *)array
              options:(NSStringCompareOptions)mask {
    NSRange range = [self rangeOfString:searchString options:mask range:searchRange];
    if (range.location != NSNotFound) {
        [array addObject:[NSValue valueWithRange:range]];
        [self rangeOfString:searchString
                      range:NSMakeRange(range.location + range.length, self.length - (range.location + range.length))
                      array:array
                    options:mask];
    }
}
    
    
#pragma mark - 时间转化
+ (NSString *)timeIntervalToMMSSFormat:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = ti / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours,(long)minutes, (long)seconds];
}
    
    
+(NSString*)timeStringForTimeInterval:(NSTimeInterval)timeInterval{
    NSInteger ti = (NSInteger)timeInterval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    if (hours > 0)
    {
        return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    }
    else
    {
        return  [NSString stringWithFormat:@"%02li:%02li", (long)minutes, (long)seconds];
    }
}
    
+ (NSString *)timeFormatted:(NSInteger)totalSeconds {
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02zd:%02zd:%02zd",hours, minutes, seconds];
}
    
+ (NSInteger)secondFromTime:(NSString *)time{
    if(time.length == 0 || ![time isTime]){
        return 0;
    }
    NSArray *times = [time componentsSeparatedByString:@":"];
    NSString *hoursStr = times[0];
    NSString *minutesStr = times[1];
    NSString *secondsStr = times[2];
    NSInteger seconds = [hoursStr integerValue] * 3600 + [minutesStr integerValue] * 60 + [secondsStr integerValue];
    return seconds;
    
}

@end
