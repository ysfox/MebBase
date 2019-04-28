//
//  UIButton+Extension.h
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

@interface UIButton (Extension)

/** 徽章标签 */
@property (strong, atomic)UILabel *badge;
/** 徽章标签显示的内容 */
@property (nonatomic)NSString *badgeValue;
/** 徽章标签的背景颜色 */
@property (nonatomic)UIColor *badgeBGColor;
/** 徽章标签文字颜色 */
@property (nonatomic)UIColor *badgeTextColor;
/** 徽章标签文字字体 */
@property (nonatomic)UIFont *badgeFont;
/** 徽章标签内容间距 */
@property (nonatomic)CGFloat badgePadding;
/** 徽章标签最小尺寸 */
@property (nonatomic)CGFloat badgeMinSize;
/** 徽章内容距离BarButtonItem的x偏移量 */
@property (nonatomic)CGFloat badgeOriginX;
/** 徽章内容距离BarButtonItem的y偏移量 */
@property (nonatomic)CGFloat badgeOriginY;
/** 如果徽章内容为数字，当徽章内容为0的时候自动隐藏徽章 */
@property BOOL shouldHideBadgeAtZero;
/** 徽章内容改变时候有一个瘫痪动画，是否只是这个动画 */
@property BOOL shouldAnimateBadge;


/**
 *  发送按钮 增加发言间隔
 *
 *  @param timeLine 间隔时间
 */
- (void)startWithTimeInterval:(double)timeLine;



/**
 *  快速创建按钮的方法
 *
 *  @param frame         按钮尺寸
 *  @param backImageName 按钮背景图片名
 *  @param imageName     图片名
 *  @param tag           tag
 *  @param target        目标
 *  @param action        动作
 *  @param title         标题
 *
 *  @return 创建的按钮
 */
+(UIButton*)buttonWithFrame:(CGRect)frame
              backImageName:(NSString *)backImageName
                  imageName:(NSString*)imageName
                        tag:(NSInteger)tag
                     target:(id)target
                     action:(SEL)action
                      title:(NSString*)title;


/**
 *  创建按钮的方法
 *
 *  @param frame           尺寸
 *  @param normalBgColor   默认颜色
 *  @param selectedBgColor 选中颜色
 *  @param tag             tag
 *  @param target          目标
 *  @param action          动作
 *  @param title           标题
 *
 *  @return 返回创建的按钮
 */
+(UIButton *)buttonWithFrame:(CGRect)frame
               normalBgColor:(UIColor *)normalBgColor
             selectedBgColor:(UIColor *)selectedBgColor
                         tag:(NSInteger)tag
                      target:(id)target
                      action:(SEL)action
                       title:(NSString *)title;


/**
 *  创建按钮的方法
 *
 *  @param frame              尺寸
 *  @param normalTitleColor   默认文字的颜色
 *  @param selectedTitleColor 选中文字颜色
 *  @param tag                tag
 *  @param target             目标
 *  @param action             动作
 *  @param title              标题
 *
 *  @return 返回创建的按钮
 */
+(UIButton *)buttonWithFrame:(CGRect)frame
            normalTitleColor:(UIColor *)normalTitleColor
          selectedTitleColor:(UIColor *)selectedTitleColor
             backGroundColor:(UIColor *)backGroundColor
                         tag:(NSInteger)tag
                      target:(id)target
                      action:(SEL)action
                        font:(UIFont *)font
                       title:(NSString *)title;




/**
 *  快速创建默认背景和选中背景按钮
 *
 *  @param frame                   尺寸
 *  @param normalTitleColor        默认文字颜色
 *  @param selectedTitleColor      选中文字颜色
 *  @param normalBackGroundColor   默认背景颜色
 *  @param selectedBackGroundColor 选中背景颜色
 *  @param tag                     tag标签
 *  @param target                  目标
 *  @param action                  动作
 *  @param font                    文字字体
 *  @param title                   标题
 *
 *  @return 返回创建好的按钮
 */
+(UIButton *)buttonWithFrame:(CGRect)frame
            normalTitleColor:(UIColor *)normalTitleColor
          selectedTitleColor:(UIColor *)selectedTitleColor
       normalBackGroundColor:(UIColor *)normalBackGroundColor
     selectedBackGroundColor:(UIColor *)selectedBackGroundColor
                         tag:(NSInteger)tag
                      target:(id)target
                      action:(SEL)action
                        font:(UIFont *)font
                       title:(NSString *)title;


/**
 *  快速创建按钮~
 *
 *  @param frame                   尺寸
 *  @param normalTitleColor        默认文字颜色
 *  @param selectedTitleColor      选中文字颜色
 *  @param hightlightTitleColor    高亮文字颜色
 *  @param normalBackGroundColor   默认背景颜色
 *  @param selectedBackGroundColor 选中背景颜色
 *  @param hightlightBackGroundColor 高亮背景颜色
 *  @param tag                     tag标签
 *  @param target                  目标
 *  @param action                  动作
 *  @param font                    文字字体
 *  @param title                   标题
 *
 *  @return 返回创建好的按钮
 */
+(UIButton *)buttonWithFrame:(CGRect)frame
            normalTitleColor:(UIColor *)normalTitleColor
          selectedTitleColor:(UIColor *)selectedTitleColor
        hightlightTitleColor:(UIColor *)hightlightTitleColor
       normalBackGroundColor:(UIColor *)normalBackGroundColor
     selectedBackGroundColor:(UIColor *)selectedBackGroundColor
   hightlightBackGroundColor:(UIColor *)hightlightBackGroundColor
                         tag:(NSInteger)tag
                      target:(id)target
                      action:(SEL)action
                        font:(UIFont *)font
                       title:(NSString *)title;



/**
 *  快速创建创建按钮的方法
 *
 *  @param title              按钮文字
 *  @param font               按钮字体
 *  @param verticalPadding    按钮文字水平间距
 *  @param horizontalPadding  按钮文字距离垂直间距
 *  @param normalTitleColor   默认文字颜色
 *  @param selectedTitleColor 选中文字颜色
 *  @param backGroundColor    按钮背景颜色
 *  @param tag                标签
 *  @param target             目标
 *  @param action             动作
 *
 *  @return 返回创建的按钮
 */
+(UIButton *)buttonWithTitle:(NSString *)title
                        font:(UIFont *)font
             verticalPadding:(CGFloat)verticalPadding
           horizontalPadding:(CGFloat)horizontalPadding
            normalTitleColor:(UIColor *)normalTitleColor
          selectedTitleColor:(UIColor *)selectedTitleColor
             backGroundColor:(UIColor *)backGroundColor
                         tag:(NSInteger)tag
                      target:(id)target
                      action:(SEL)action;



/**
 *  创建按钮
 *
 *  @param normalImage   默认状态按钮
 *  @param selectedImage 选中状态按钮
 *  @param tag           标记
 *  @param target        目标
 *  @param action        动作
 *
 *  @return 返回按钮
 */
+(UIButton *)buttonWithNormalImage:(NSString *)normalImage
                     selectedImage:(NSString *)selectedImage
                               tag:(NSInteger)tag
                            target:(id)target
                            action:(SEL)action;


@end
