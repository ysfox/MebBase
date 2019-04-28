//
//  UIImageView+Extension.h
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

static NSString *gifName = @"";

@interface UIImageView (Extension)

/**
 *  设置头像
 *
 *  @param url 头像的url
 */
- (void)setHeader:(NSString *)url;

/**
 *  根据当前图片视图设置放大缩小尺寸
 *
 *  @return 返回尺寸
 */
- (CGRect)setMaxMinZoomScalesForCurrentBoundWithImageView;



#pragma mark - 创建快捷方式
/**
 *  快速创建图片视图
 *
 *  @param imageName   图片名称
 *  @param contentMode 图片模式
 *
 *  @return 返回创建的图片视图
 */
+ (UIImageView *)imageViewWithImage:(NSString *)imageName
                        contentMode:(UIViewContentMode)contentMode;



#pragma mark - Effect(UIImageView的动画效果，包括裁剪分屏，放大溶解)

/**
 *  图片视图的分屏动画，裁剪一个图片视图的图片为指定尺寸的两部分，然后粘贴到指定的视图上，然后延时指定时间做分屏动画
 *
 *  @param topSize    截取顶部尺寸图片的尺寸
 *  @param bottomSize 截取底部尺寸的图片的尺寸
 *  @param parentView 父类视图
 *  @param delayTime  延时多少时间开始做分屏动画
 */
- (void)splitTopImageSize:(CGRect)topSize
          bottomImageSize:(CGRect)bottomSize
                addToView:(UIView *)parentView
                delayTime:(CGFloat)delayTime;

@end
