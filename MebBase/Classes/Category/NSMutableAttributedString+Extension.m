//
//  NSMutableAttributedString+Extension.m
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

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

/**
 *  给制定的子类字符串添加上颜色
 *
 *  @param color     颜色
 *  @param substring 要添加颜色的字符
 */
- (void)addColor:(UIColor *)color substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
    }
}

/**
 *  给指定的子类字符串添加上背景颜色
 *
 *  @param color     颜色
 *  @param substring 要添加背景颜色的字符串
 */
- (void)addBackgroundColor:(UIColor *)color substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSBackgroundColorAttributeName
                     value:color
                     range:range];
    }
}

/**
 *  给指定的子类字符串添加上下划线
 *
 *  @param color     下划线颜色
 *  @param substring 子类字符串
 */
- (void)addUnderlineForSubstring:(NSString *)substring lineColor:(UIColor *)color{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [self addAttribute: NSUnderlineStyleAttributeName
                     value:@(NSUnderlineStyleSingle)
                     range:range];
        [self addAttribute:NSUnderlineColorAttributeName value:color range:range];
    }
}

/**
 *  给指定的子类字符串添加上贯穿线
 *
 *  @param thickness    贯穿线厚度
 *  @param strikeColor  贯穿线颜色
 *  @param substring    子类字符串
 */
- (void)addStrikeThrough:(int)thickness strikeColor:(UIColor *)strikeColor substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [self addAttribute: NSStrikethroughStyleAttributeName
                     value:@(thickness)
                     range:range];
        [self addAttribute:NSStrikethroughColorAttributeName value:strikeColor range:range];
    }
}

/**
 *  给指定的子类字符串添加上阴影
 *
 *  @param color     颜色
 *  @param width     宽度
 *  @param height    高度
 *  @param radius    半径
 *  @param substring 子类字符串
 */
- (void)addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound && color != nil) {
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowColor:color];
        [shadow setShadowOffset:CGSizeMake (width, height)];
        [shadow setShadowBlurRadius:radius];
        
        [self addAttribute: NSShadowAttributeName
                     value:shadow
                     range:range];
    }
}


/**
 *  给指定的字符串添加字体
 *
 *  @param fontName  字体名称
 *  @param fontSize  字体大小
 *  @param substring 子类字符串
 */
- (void)addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound && fontName != nil) {
        UIFont * font = [UIFont fontWithName:fontName size:fontSize];
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}

/**
 *  给指定的字符串添加倾斜
 *
 *  @param substring 子类字符串
 *  @param value     倾斜度
 */
- (void)addItalicForSubstring:(NSString *)substring value:(float)value{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound && value != 0) {
        [self addAttribute:NSObliquenessAttributeName value:[NSNumber numberWithFloat:value] range:range];
    }
}


/**
 *  给指定的字符串添加字体
 *
 *  @param font      字体
 *  @param substring 子类字符串
 */
- (void)addFont:(UIFont *)font substring:(NSString *)substring {
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound && font != nil) {
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}


/**
 *  给指定的字符串添加对齐方式
 *
 *  @param alignment 对齐方式
 *  @param substring 子类字符串
 */
- (void)addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        NSMutableParagraphStyle* style=[[NSMutableParagraphStyle alloc]init];
        style.alignment = alignment;
        [self addAttribute: NSParagraphStyleAttributeName
                     value:style
                     range:range];
    }
}


/**
 *  给俄罗斯字符串添加颜色
 *
 *  @param color 颜色
 */
- (void)addColorToRussianText:(UIColor *)color{
    
    if(color == nil) return;
    
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"];
    
    NSRange searchRange = NSMakeRange(0,self.string.length);
    NSRange foundRange;
    while (searchRange.location < self.string.length) {
        searchRange.length = self.string.length-searchRange.location;
        foundRange = [self.string rangeOfCharacterFromSet:set options:NSCaseInsensitiveSearch range:searchRange];
        if (foundRange.location != NSNotFound) {
            [self addAttribute:NSForegroundColorAttributeName
                         value:color
                         range:foundRange];
            
            searchRange.location = foundRange.location+1;
            
        } else {
            // no more substring to find
            break;
        }
    }
}

/**
 *  给指定的字符串添加描边空心字颜色
 *
 *  @param color     颜色
 *  @param thickness 描边厚度
 *  @param substring 子类字符串
 */
- (void)addStrokeColor:(UIColor *)color thickness:(int)thickness substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSStrokeColorAttributeName
                     value:color
                     range:range];
        [self addAttribute:NSStrokeWidthAttributeName
                     value:@(thickness)
                     range:range];
    }
}


/**
 *  给指定的字符串添加垂直条纹
 *
 *  @param glyph     是否条纹
 *  @param substring 子类字符串
 */
- (void)addVerticalGlyph:(BOOL)glyph substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:@(glyph)
                     range:range];
    }
}



/**
 *  给指定的字符串添加超链接事件
 *
 *  @param url       跳转的url
 *  @param color     超链接颜色
 *  @param substring 子类字符串
 */
- (void)addLinkUrl:(NSString *)url linkColor:(UIColor *)color substring:(NSString *)substring{
    NSRange range = [self.string rangeOfString:substring options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [self addAttribute:NSLinkAttributeName value:[NSURL URLWithString:url] range:range];
        [self addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
    }
}



/**
 *  给指定的字符串字符之间添加间距
 *
 *  @param kern      间距值
 *  @param subString 子类字符串
 */
- (void)addKern:(float)kern subString:(NSString *)subString{
    NSRange range = [self.string rangeOfString:subString options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [self addAttribute:NSKernAttributeName value:@(kern) range:range];
    }
}


/**
 *  在富文本中指定的地方插入一个图片
 *
 *  @param imageName 图片名称
 *  @param imageSize 图片尺寸
 *  @param loc       插入的索引
 */
- (void)addImageName:(NSString *)imageName imageSize:(CGSize)imageSize atIndex:(NSUInteger)loc{
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    textAttachment.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    NSAttributedString *coreText = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self insertAttributedString:coreText atIndex:loc];
}


/**
 *  获取文本的尺寸
 *
 *  @param text 文本
 *  @param font 文本字体
 *  @param maxW 限制最大宽度
 *  @param maxH 限制最大高度
 *
 *  @return 返回计算后的尺寸
 */
+ (CGSize)sizeFromText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW maxH:(CGFloat)maxH{
    NSMutableAttributedString *coreText = [[NSMutableAttributedString alloc] initWithString:text];
    [coreText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, coreText.length)];
    return [coreText boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}




#pragma mark - 段落操作
/**
 *  段落首行头部缩进
 *
 *  @param indent 缩进距离
 */
- (void)paragraphFirstLineHeadIndent:(CGFloat)indent{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.firstLineHeadIndent = indent;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
}


/**
 *  段落其它行头部缩进
 *
 *  @param indent 缩进距离
 */
- (void)paragraphOtherLineHeadIndent:(CGFloat)indent{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.headIndent = indent;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
}

/**
 *  段落中行与行之间的间距
 *
 *  @param spac 间距
 */
- (void)paragraphsLineSpace:(CGFloat)spac{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = spac;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
}

/**
 *  段落和段落之间的距离
 *
 *  @param spac 距离
 */
- (void)paragraphsSpacing:(CGFloat)spac{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.paragraphSpacing = spac;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
}


/**
 *  段落对齐方式
 *
 *  @param alignment 对齐方式
 */
- (void)paragraphAlignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = alignment;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
}


/**
 *  段落断行模式
 *
 *  @param lineBreakMode 断行模式
 */
- (void)paragraphLineBreakMode:(NSLineBreakMode)lineBreakMode{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = lineBreakMode;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
}

@end
