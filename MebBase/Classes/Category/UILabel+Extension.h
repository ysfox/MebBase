//
//  UILabel+Extension.h
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
/**  NSAttributedString属性字符串Attributed结构体 */
typedef struct{
    /**
     *  待修改的Attributed的格式名称常用有：
     NSFontAttributeName(字体)
     NSParagraphStyleAttributeName(段落格式)
     NSForegroundColorAttributeName(前景色)
     NSBackgroundColorAttributeName(背景色)
     NSUnderlineStyleAttributeName(下划线)
     */
    __unsafe_unretained NSString * attributeName;
    
    /** 格式的值 */
    __unsafe_unretained id value;
    
    /** 需要格式的文字的范围 */
    NSRange range;
    
}USAttributedMode;

/**
 *  PZAttributedMode制造 内链函数
 *
 *  @param s 待修改的Attributed的格式名称
 *  @param i 格式的值
 *  @param r 需要格式的文字的范围
 *
 *  @return 赋值过的PZAttributedMode
 */
CG_INLINE USAttributedMode PZAttributedMake(NSString * s, id i, NSRange r){
    USAttributedMode mode;
    mode.attributeName = s;
    mode.value = i;
    mode.range = r;
    return mode;
}

/**
 *  PZAttributedMode转NSValue 内链函数
 *
 *  @param aMode 需要转换的PZAttributedMode结构体
 *
 *  @return 转换PZAttributedMode后的Value
 */
CG_INLINE NSValue* PZAttributedModeToValue(USAttributedMode aMode){
    NSValue * value = [NSValue valueWithBytes:&aMode objCType:@encode(USAttributedMode)];
    return value;
}

/**
 *  NSValue转PZAttributedMode 内链函数
 *
 *  @param value 需要转换成PZAttributedMode的NSValue
 *
 *  @return 转换Value后的PZAttributedMode
 */
CG_INLINE USAttributedMode ValueToPZAttributedMode(NSValue * value){
    USAttributedMode aMode;
    [value getValue:&aMode];
    return aMode;
}

/** label基本设置Block */
typedef void (^USLabelBasicSetBlock)(UILabel * lab);

/** label动画执行后的Block */
typedef void (^USLabelAfterHandleBlock)(UILabel * lab,NSTimeInterval time);

@interface UILabel (Extension)

#pragma mark - 创建
/**
 *  快速创建标签
 *
 *  @param frame    尺寸
 *  @param text     文字
 *  @param fontSize 文字大小
 *  @param font 字体
 *
 *  @return 返回标签
 */
+(UILabel*)labelWithFrame:(CGRect)frame
                     text:(NSString*)text
                 fontSize:(int)fontSize;


/**
 *  快速创建标签
 *
 *  @param frame     尺寸
 *  @param text      文本
 *  @param font      字体
 *  @param textColor 文本颜色
 *
 *  @return 返回标签
 */
+(UILabel*)labelWithFrame:(CGRect)frame
                     text:(NSString*)text
                     font:(UIFont *)font
                textColor:(UIColor *)textColor;


/**
 *  快速创建标签，会根据文字和字体自动计算尺寸
 *
 *  @param text      文字
 *  @param font      字体
 *  @param textColor 文本颜色
 *
 *  @return 返回快速创建的标签
 */
+(UILabel *)labelWithText:(NSString *)text
                     font:(UIFont *)font
                textColor:(UIColor *)textColor;


/**
 *  快速创建标签，会根据文字和字体自动计算尺寸
 *
 *  @param text      文字
 *  @param font      字体
 *  @param maxW      最大宽度
 *  @param textColor 文字颜色
 *
 *  @return 返回快捷创建的标签
 */
+(UILabel *)labelWithText:(NSString *)text
                     font:(UIFont *)font
                     maxW:(CGFloat)maxW
                textColor:(UIColor *)textColor;


#pragma mark - 特效
//MARK-感谢SystemOuter的源码
/**
 *  创建一个Label标签
 *
 *  @param basicSet 包含基本设置（参数为当前创建的label）
 *
 *  @return 返回创建的label
 */
+(UILabel *)label_Alloc:(USLabelBasicSetBlock)basicSet;

/**
 *  创建一个Label标签
 *
 *  @param basicSet     包含基本设置（参数为当前创建的label）
 *  @param superView    要添加到的SuperView
 *
 *  @return 返回创建的label
 */
+(UILabel *)label_Alloc:(USLabelBasicSetBlock)basicSet addView:(UIView *)superView;

/**
 *  label标签，基本设置
 *
 *  @param basicSet basicSet 包含基本设置（参数为当前创建的label）
 */
-(void)label_basicSet:(USLabelBasicSetBlock)basicSet;

/**
 *  创建一个Label标签，其中文字按指定方向自适应，并自动修改label尺寸
 *
 *  @param basicSet      basicSet 包含基本设置（参数为当前创建的label）
 *  @param text          文字内容
 *  @param lineBreakMode label换行格式
 *  @param font          label字体
 *  @param frame         label位置
 *  @param heightMask    是否是高度根据文字自适应
 *
 *  @return 返回创建的label
 */
+(UILabel *)label_AllocAutoMask:(USLabelBasicSetBlock)basicSet withText:(NSString *)text lineBreakMode:(NSLineBreakMode)lineBreakMode font:(UIFont *)font withLabelFrame:(CGRect)frame heightMask:(BOOL)heightMask;

/**
 *  创建一个Label标签，其中文字按指定方向自适应，并自动修改label尺寸
 *
 *  @param basicSet      basicSet 包含基本设置（参数为当前创建的label）
 *  @param text          文字内容
 *  @param lineBreakMode label换行格式
 *  @param font          label字体
 *  @param frame         label位置
 *  @param heightMask    是否是高度根据文字自适应
 *  @param superView     要添加到的SuperView
 *
 *  @return 返回创建的label
 */
+(UILabel *)label_AllocAutoMask:(USLabelBasicSetBlock)basicSet withText:(NSString *)text lineBreakMode:(NSLineBreakMode)lineBreakMode font:(UIFont *)font withLabelFrame:(CGRect)frame heightMask:(BOOL)heightMask addView:(UIView *)superView;

/**
 *  label标签，文字按指定方向自适应，并自动修改label尺寸
 *
 *  @param heightMask 是否是高度根据文字自适应
 */
-(void)label_AutoMaskWithHeightMask:(BOOL)heightMask;

/**
 *  创建一个Label标签，其中文字颜色按照指定图片渐变
 *
 *  @param basicSet    basicSet 包含基本设置（参数为当前创建的label）
 *  @param image       文字渐变图片
 *
 *  @return 返回创建的label
 */
+(UILabel *)label_AllocColorAdverb:(USLabelBasicSetBlock)basicSet withColor:(UIImage *)image;

/**
 *  创建一个Label标签，其中文字颜色按照指定图片渐变
 *
 *  @param basicSet    basicSet 包含基本设置（参数为当前创建的label）
 *  @param image       文字渐变图片
 *  @param superView   要添加到的SuperView
 *
 *  @return 返回创建的label
 */
+(UILabel *)label_AllocColorAdverb:(USLabelBasicSetBlock)basicSet withColor:(UIImage *)image addView:(UIView *)superView;

/**
 *  label标签，文字颜色按照指定图片渐变
 *
 *  @param image 文字渐变图片
 */
-(void)label_ColorAdverb:(UIImage *)image;

/**
 *  创建一个Label标签，其中文字格式按照给定格式进行编码显示
 *
 *  @param basicSet        basicSet 包含基本设置（参数为当前创建的label）
 *  @param text            文字内容
 *  @param attributedArray 格式数组，包含PZAttributedMode的NSValue数组，存的时候将结构体转换为NSValue
 *
 *  @return 返回对应Label
 */
+(UILabel *)label_AllocAttributedString:(USLabelBasicSetBlock)basicSet withText:(NSString *)text attributedMode:(NSArray<NSValue *> *)attributedArray;

/**
 *  创建一个Label标签，其中文字格式按照给定格式进行编码显示
 *
 *  @param basicSet        basicSet 包含基本设置（参数为当前创建的label）
 *  @param text            文字内容
 *  @param attributedArray 格式数组，包含PZAttributedMode的NSValue数组，存的时候将结构体转换为NSValue
 *  @param superView       要添加到的SuperView
 *
 *  @return 返回对应Label
 */
+(UILabel *)label_AllocAttributedString:(USLabelBasicSetBlock)basicSet withText:(NSString *)text attributedMode:(NSArray<NSValue *> *)attributedArray addView:(UIView *)superView;

/**
 *  label标签，其中文字格式按照给定格式进行编码显示
 *
 *  @param text            文字内容
 *  @param attributedArray 格式数组，包含PZAttributedMode的NSValue数组，存的时候将结构体转换为NSValue
 */
-(void)label_AttributedString:(NSString *)text attributedMode:(NSArray<NSValue *> *)attributedArray;

/**
 *  显示下划线
 */
-(void)showUnderLine;

/**
 *  显示删除线
 *
 *  @param color 删除线颜色
 */
-(void)showDeleteLine:(UIColor *)color;

/**
 *  自动横移<注意设置一直重复动画后 不会回调“handleBlock”操作>
 *
 *  @param handleBlock      横移一次之后的动画
 *  @param bol_NeedRepead   是否要重复
 *
 */
-(void)lab_AutoRowMove:(USLabelAfterHandleBlock)handleBlock withReqeat:(BOOL)bol_NeedRepead;

@end
