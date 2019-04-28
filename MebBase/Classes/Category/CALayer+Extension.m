//
//  CALayer+Extension.m
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

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

/**
 *  给图层添加动画，动画必须满足协议条件
 *
 *  @param animation 是否动画
 */
+(void)addAnimtaion:(id)animation{
    //TODO 添加指定的动画
}


/**
 *  原型图层
 */
-(void)cornerLayer{
    self.masksToBounds = YES;
    self.cornerRadius = CGRectGetHeight(self.bounds) / 2;
}

/**
 *  不圆角图层
 */
-(void)notCornerLayer{
    self.cornerRadius = 0.0;
    self.borderWidth = 0.0;
}

/**
 *  圆角图层
 *
 *  @param radius 指定圆角半径
 */
-(void)cornerLayerWithRadius:(CGFloat)radius{
    self.masksToBounds = YES;
    self.cornerRadius = radius;
}

/**
 *  给图层添加
 */
-(void)borderLayerColor:(UIColor*)color
            borderWidth:(CGFloat)borderWidth{
    self.borderWidth = borderWidth;
    self.borderColor = color.CGColor;
}


/**
 *  清理线条
 */
-(void)clearBorderLine{
    self.borderWidth = 0;
    self.borderColor = [UIColor clearColor].CGColor;
}



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
                 shadowOpacity:(float)opacity{
    self.shadowColor = color.CGColor;
    self.shadowOpacity = opacity;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.masksToBounds = NO;
    
    CGSize size = self.bounds.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width * 0.33f, size.height * 0.66f)];
    [path addLineToPoint:CGPointMake(size.width * 0.66f, size.height * 0.66f)];
    [path addLineToPoint:CGPointMake(size.width * 1.15f, size.height * 1.15f)];
    [path addLineToPoint:CGPointMake(size.width * -0.15f, size.height * 1.15f)];
    self.shadowPath = path.CGPath;
}

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
                shadowOpacity:(float)opacity{
    self.shadowColor = color.CGColor;
    self.shadowOpacity = opacity;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.masksToBounds = NO;
    
    CGSize size = self.bounds.size;
    CGRect ovalRect = CGRectMake(0.0f, size.height + 5, size.width - 10, 15);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    self.shadowPath = path.CGPath;
}


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
                shadowOpacity:(float)opacity{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGRect rect = self.bounds;
    CGPoint topLeft         = rect.origin;
    CGPoint bottomLeft     = CGPointMake(0.0, CGRectGetHeight(rect)+radius);
    CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect)-curve);
    CGPoint bottomRight     = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)+radius);
    CGPoint topRight     = CGPointMake(CGRectGetWidth(rect), 0.0);
    
    [path moveToPoint:topLeft];
    [path addLineToPoint:bottomLeft];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:bottomMiddle];
    [path addLineToPoint:topRight];
    [path addLineToPoint:topLeft];
    [path closePath];
    
    self.borderColor = borderColor.CGColor;
    self.borderWidth = borderWidth;
    self.shadowColor = color.CGColor;
    self.shadowOffset = offset;
    self.shadowOpacity = opacity;
    self.shouldRasterize = YES;
    self.shadowPath = path.CGPath;
}


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
                             position:(CGPoint)position{
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds =  bounds;
    layer.backgroundColor = color.CGColor;
    
    return layer;
}


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
                                    position:(CGPoint)point{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:startPoint];
    [path addLineToPoint:nextPoint];
    [path addLineToPoint:endPoint];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = lineWidth;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    layer.position = point;
    
    return layer;
}


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
                             andPosition:(CGPoint)point{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    layer.path = path.CGPath;
    layer.lineWidth = lineWidth;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}


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
                         position:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:fromPoint];
    [path addLineToPoint:toPoint];
    layer.path = path.CGPath;
    layer.lineWidth = lineWidth;
    layer.strokeColor = lineColor.CGColor;
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = position;
    [self addSublayer:layer];
}


/**
 *  给视图层添加渐变层
 *
 *  @param colors    颜色数组
 *  @param fromPoint 开始点(比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0))
 *  @param toPoint   结束点(比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0))
 */
- (void)addGradientLayerWithFrame:(CGRect)frame
                           Colors:(NSArray *)colors
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    if(CGRectIsNull(frame)){
        newShadow.frame = self.bounds;
    }
    newShadow.frame = frame;
    newShadow.colors = colors;
    newShadow.startPoint = startPoint;
    newShadow.endPoint = endPoint;
    [self addSublayer:newShadow];
}


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
                            position:(CGPoint)point{
    CATextLayer *layer = [CATextLayer new];
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attrs = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    layer.bounds = CGRectMake(0, 0, size.width, size.height);
    layer.string = string;
    layer.font = (__bridge CFTypeRef)(font);
    layer.foregroundColor = foregroundColor.CGColor;
    layer.backgroundColor = backgroundColor.CGColor;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    layer.position = point;
    return layer;
    
}


#pragma mark - 动画
/**
 *  水平方向的抖动动画
 */
- (void)horizontalShakeAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.5f;
    animation.values = @[@(-12), @(12), @(-8), @(8), @(-4), @(4), @(0)];
    [self addAnimation:animation forKey:@"shake"];
}


/**
 *  垂直方向的抖动动画
 */
- (void)verticalShakeAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.5f;
    animation.values = @[@(-12), @(12), @(-8), @(8), @(-4), @(4), @(0)];
    [self addAnimation:animation forKey:@"shake"];
}





#pragma mark - 其它好玩的
/**
 *  添加粒子效果
 *
 *  @param emitterName       粒子图片名称
 *  @param emmiterFlakeColor 粒子花火的颜色
 */
-(void)emitterName:(NSString *)emitterName
 emmiterFlakeColor:(UIColor *)emmiterFlakeColor{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    
    snowEmitter.emitterPosition = CGPointMake(self.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize  = CGSizeMake(self.bounds.size.width * 2.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode  = kCAEmitterLayerOutline;
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate    = 10.0;
    snowflake.lifetime    = 120.0;
    snowflake.velocity    = -10;
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 2;
    snowflake.emissionRange = 0.5 * M_PI;
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents  = (id) [[UIImage imageNamed:emitterName] CGImage];
    snowflake.color    = [emmiterFlakeColor CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self insertSublayer:snowEmitter atIndex:0];
}


@end
