//
//  CALayer+Extension.h
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

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Extension)

/**
 *  给图层添加动画，动画必须满足协议条件
 *
 *  @param animation 是否动画
 */
+(void)addAnimtaion:(id)animation;


/**
 *  圆角图层
 */
-(void)cornerLayer;

/**
 *  不圆角图层
 */
-(void)notCornerLayer;

/**
 *  圆角图层
 *
 *  @param radius 指定圆角半径
 */
-(void)cornerLayerWithRadius:(CGFloat)radius;

/**
 *  给图层添加边线
 */
-(void)borderLayerColor:(UIColor*)color
            borderWidth:(CGFloat)borderWidth;


/**
 *  清理线条
 */
-(void)clearBorderLine;

#pragma mark - shadow
/**
 *  添加梯形阴影
 *
 *  @param offset  阴影偏移量
 *  @param color   阴影颜色
 *  @param radius  阴影半径
 *  @param opacity 阴影透明度
 */
-(void)trapezoidalShadowOffset:(CGSize)offset
                   shadowColor:(UIColor *)color
                  shadowRadius:(CGFloat)radius
                 shadowOpacity:(float)opacity;

/**
 *  添加椭圆形阴影
 *
 *  @param offset  阴影偏移量
 *  @param color   阴影颜色
 *  @param radius  阴影半径
 *  @param opacity 阴影透明度
 */
-(void)ellipticalShadowOffset:(CGSize)offset
                  shadowColor:(UIColor *)color
                 shadowRadius:(CGFloat)radius
                shadowOpacity:(float)opacity;

/**
 *  添加卷曲形阴影
 *
 *  @param offset  阴影偏移量
 *  @param color   阴影颜色
 *  @param radius  阴影半径
 *  @param opacity 阴影透明度
 */
-(void)curlShadowShadowOffset:(CGSize)offset
                  shadowColor:(UIColor *)color
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 shadowRadius:(CGFloat)radius
                  shadowCurve:(CGFloat)curve
                shadowOpacity:(float)opacity;




#pragma mark - 创建
/**
 *  创建一个背景层
 *
 *  @param bounds   尺寸边间
 *  @param color    颜色
 *  @param position 定位原点
 *
 *  @return 返回创建的背景层
 */
+ (CALayer *)backgroudLayerWithBounds:(CGRect)bounds
                                color:(UIColor *)color
                             position:(CGPoint)position;


/**
 *  创建一个三角形指示器
 *
 *  @param startPoint 起始点(推荐CGPointMake(0, 0))
 *  @param nextPoint  下一个点(推荐CGPointMake(8, 0))
 *  @param endPoint   结束点(推荐CGPointMake(4, 5))
 *  @param color      三角形颜色
 *  @param lineWidth  线条宽度(推荐1.0)
 *  @param point      定位原点
 *
 *  @return 返回创建的三角形层
 */
- (CAShapeLayer *)triangleIndicatorFromPoint:(CGPoint)startPoint
                                   nextPoint:(CGPoint)nextPoint
                                    endPoint:(CGPoint)endPoint
                                       color:(UIColor *)color
                                   lineWidth:(CGFloat)lineWidth
                                    position:(CGPoint)point;


/**
 *  创建一个分割线
 *
 *  @param startPoint 线条起始点
 *  @param endPoint   线条结束点
 *  @param lineWidth  线条宽度
 *  @param color      线条宽度
 *  @param point      线条定位点
 *
 *  @return 返回创建好的线条层
 */
+ (CAShapeLayer *)separatorLineFromPoint:(CGPoint)startPoint
                                endPoint:(CGPoint)endPoint
                               lineWidth:(CGFloat)lineWidth
                                   color:(UIColor *)color
                             andPosition:(CGPoint)point;



/**
 *  给视图层添加边线
 *
 *  @param fromPoint 开始点
 *  @param toPoint   结束点
 *  @param lineWidth 线宽
 *  @param lineColor 线颜色
 *  @param position  坐标定位点
 */
- (void)addSeparatorLiewFromPoint:(CGPoint)fromPoint
                          toPoint:(CGPoint)toPoint
                        lineWidth:(CGFloat)lineWidth
                        lineColor:(UIColor *)lineColor
                         position:(CGPoint)position;



/**
 *  给视图层添加渐变层
 *
 *  @param frame      尺寸
 *  @param colors     颜色数组
 *  @param startPoint 开始点(比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0))
 *  @param endPoint   结束点(比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0))
 */
- (void)addGradientLayerWithFrame:(CGRect)frame
                           Colors:(NSArray *)colors
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint;


/**
 *  创建文字层
 *
 *  @param string          文字
 *  @param font            文字字体
 *  @param maxW            最大宽度
 *  @param foregroundColor 前景层颜色
 *  @param backgroundColor 背景颜色
 *  @param point           其实原点
 *
 *  @return 返回创建的文字层
 */
+ (CATextLayer *)textLayerWithString:(NSString *)string
                                font:(UIFont *)font
                                maxW:(CGFloat)maxW
                     foregroundColor:(UIColor *)foregroundColor
                     backgroundColor:(UIColor *)backgroundColor
                            position:(CGPoint)point;


#pragma mark - 动画
/**
 *  水平方向的抖动动画
 */
- (void)horizontalShakeAnimation;


/**
 *  垂直方向的抖动动画
 */
- (void)verticalShakeAnimation;



#pragma mark - 其它好玩的
/**
 *  添加粒子效果
 *
 *  @param emitterName       粒子图片名称
 *  @param emmiterFlakeColor 粒子花火的颜色
 */
-(void)emitterName:(NSString *)emitterName
 emmiterFlakeColor:(UIColor *)emmiterFlakeColor;

@end
