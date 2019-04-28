//
//  UIBarButtonItem+Extension.h
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

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

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
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                          highImage:(NSString *)highImage;


/**
 *  创建一个item
 *
 *  @param target       点击item后调用哪个对象的方法
 *  @param action       点击item后调用target的哪个方法
 *  @param image        图片
 *  @param selectImage  选中的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                        selectImage:(NSString *)selectImage;


/**
 *  创建一个item
 *
 *  @param target        点击item后调用哪个对象的那个方法
 *  @param action        点击item后调用target的那个方法
 *  @param title         标题
 *  @param selectedTitle 选中的标题
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                      selectedTitle:(NSString *)selectedTitle;

@end
