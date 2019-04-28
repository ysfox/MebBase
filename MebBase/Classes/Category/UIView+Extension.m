//
//  UIView+Extension.m
//  MebBase
//
//  Created by meb on 2019/4/25.
//  Copyright © 2019 ysfox. All rights reserved.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\      Ysfox **
//**********************************

#import "UIView+Extension.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/** 闪光波纹按钮内部初始化矩形半径 */
const CGFloat USReippleInnerCircleInitialRaius = 20;


@interface UIView ()

@property (nonatomic, strong) CALayer           *glowLayer;
@property (nonatomic, strong) dispatch_source_t  dispatchSource;

@end

@implementation UIView (Extension)

/** setX方法 */
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


/** getX方法 */
-(CGFloat)x{
    return self.frame.origin.x;
}


/** setY方法 */
-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/** getY方法 */
-(CGFloat)y{
    return self.frame.origin.y;
}


/** setCenterX */
-(void)setCX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

/** getCenterX */
-(CGFloat)cX{
    return self.center.x;
}


/** getCenterY */
-(void)setCY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/** getCenterY */
-(CGFloat)cY{
    return self.center.y;
}


/** setWidth方法 */
-(void)setW:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/** getWidth方法 */
-(CGFloat)w{
    return self.frame.size.width;
}


/** setHeight方法 */
-(void)setH:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

/** getHeight方法 */
-(CGFloat)h{
    return self.frame.size.height;
}


/** setOrigin方法 */
-(void)setO:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

/** getOrigin方法 */
-(CGPoint)o{
    return self.frame.origin;
}


/** setSize方法 */
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/** getSize方法 */
-(CGSize)size{
    return self.frame.size;
}



- (CGFloat)t {
    
    return self.frame.origin.y;
}

- (void)setT:(CGFloat)top {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = top;
    self.frame        = newFrame;
}

- (CGFloat)b {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setB:(CGFloat)bottom {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = bottom - self.frame.size.height;
    self.frame        = newFrame;
}

- (CGFloat)l {
    
    return self.frame.origin.x;
}

- (void)setL:(CGFloat)left {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = left;
    self.frame        = newFrame;
}

- (CGFloat)r {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setR:(CGFloat)right {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = right - self.frame.size.width;
    self.frame        = newFrame;
}





- (CGFloat)middleX {
    
    return CGRectGetWidth(self.bounds) / 2.f;
}

- (CGFloat)middleY {
    
    return CGRectGetHeight(self.bounds) / 2.f;
}

- (CGPoint)middlePoint {
    
    return CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
}


- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

#pragma mark - Scale.

NSString * const _recognizerScale = @"_recognizerScale";

- (void)setScale:(CGFloat)scale {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerScale), @(scale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (CGFloat)scale {
    
    NSNumber *scaleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerScale));
    return scaleValue.floatValue;
}

#pragma mark - Angle.

NSString * const _recognizerAngle = @"_recognizerAngle";

- (void)setAngle:(CGFloat)angle {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerAngle), @(angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeRotation(angle);
}

- (CGFloat)angle {
    
    NSNumber *angleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerAngle));
    return angleValue.floatValue;
}



/**
 *  从Xib中加载一个控件出来（Xib的名字和类名一致）
 */
+ (instancetype)viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


/**
 *  从Xib中加载一个控件
 *
 *  @param nibName nib名字
 *
 *  @return 返回视图控件
 */
+ (instancetype)viewWithNibName:(NSString* )nibName {
    if (!nibName) return nil;
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [array firstObject];
}

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}


/**
 *  视图上是否包含指定的点
 *
 *  @param point 指定的点
 *
 *  @return 返回是否包含这点
 */
- (BOOL)containsPoint:(CGPoint)point{
    return  CGRectContainsPoint(self.frame,point);
}

/**
 *  视图上是否包含指定的矩形
 *
 *  @param rect 指定的点
 *
 *  @return 返回判断结果
 */
- (BOOL)containsRect:(CGRect)rect{
    return CGRectContainsRect(self.frame,rect);
}


/**
 *  深度挖掘视图的层次结构
 *
 *  @return 返回遍历到的视图层次结构
 *  @abstract 这个方法主要用于查看某个视图的层数结构,是一段xml
 */
- (NSString *)digView{
    NSMutableString *xml = [NSMutableString string];
    [xml appendFormat:@"<%@ frame=\"%@\"", self.class, NSStringFromCGRect(self.frame)];
    if (!CGPointEqualToPoint(self.bounds.origin, CGPointZero)) {
        [xml appendFormat:@" bounds=\"%@\"", NSStringFromCGRect(self.bounds)];
    }
    
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scroll = (UIScrollView *)self;
        if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, scroll.contentInset)) {
            [xml appendFormat:@" contentInset=\"%@\"", NSStringFromUIEdgeInsets(scroll.contentInset)];
        }
    }
    
    if (self.subviews.count == 0) {
        [xml appendString:@" />"];
        return xml;
    } else {
        [xml appendString:@">"];
    }
    
    for (UIView *child in self.subviews) {
        NSString *childXml = [child digView];
        [xml appendString:childXml];
    }
    [xml appendFormat:@"</%@>", self.class];
    return xml;
}



/**
 *  深度给视图的层级视图作色
 */
- (void)digViewColor{
    self.backgroundColor = [UIColor colorWithHue:(arc4random()%256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()%128/256.0)+0.5 alpha:1];
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:[UIView class]]) {
            child.backgroundColor = [UIColor colorWithHue:(arc4random()%256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()%128/256.0)+0.5 alpha:1];
            [child digViewColor];
        }
    }
}


/**
 *  截屏方法2(截取当前视图的屏幕)
 *
 *  @return 截屏的图片
 */
- (UIImage *)viewShot{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    image = [UIImage imageWithData:imageData];
    return image;
}



- (void)cornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)borderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)makeRoundedCorner:(UIRectCorner)byRoundingCorners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:byRoundingCorners cornerRadii:cornerRadii];
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    self.layer.mask = shape;
}


/**
 *  隐藏UI控件上的指定名称的所有视图,主要针对于苹果的私有APIUI组件
 *
 *  @param suffix 指定要隐藏的UI控件的后缀名称
 *
 *  @return 返回是否隐藏成功
 */
- (BOOL)hiddenPrivUI:(NSString *)suffix{
    BOOL flag = NO;
    for (UIView *child in self.subviews) {
        if ([NSStringFromClass(child.class) hasSuffix:suffix]) {
            child.hidden = YES;
            flag = YES;
        }
        [child hiddenPrivUI:suffix];
    }
    return flag;
}

/**
 *  获取视图上的指定的名称的视图，主要针对于苹果的死于哦APIUI组件
 *
 *  @param subffix 指定的需要获取的UI空间的后缀
 *
 *  @return 返回对应的视图
 */
- (UIView *)getPrivUI:(NSString *)subffix{
    return nil;
}


/**
 *  获取到视图上指定名称的所有视图，主要正对于苹果的四有APIUI组件
 *
 *  @param subffix 指定的需要获取的UI空间的后最
 *
 *  @return 返回对应的视图数组
 */
- (NSArray *)getPrivUIs:(NSString *)subffix{
    NSMutableArray *arr = [NSMutableArray new];
    for (UIView *child in self.subviews) {
        if ([NSStringFromClass(child.class) hasSuffix:subffix]) {
            [arr addObject:child];
        }
        [child hiddenPrivUI:subffix];
    }
    return arr;
}


/**
 *  获取视图所在的视图控制器
 *
 *  @return 返回获取到的视图控制器
 */
- (UIViewController *)parentViewController{
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    return object;
}


/**
 *  设置主题
 *
 *  @param containerClass 容器视图类
 *
 *  @return 返回实例化对象
 */
+ (instancetype)lt_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass{
    return [self appearanceWhenContainedIn:containerClass, nil];
}


#pragma mark -  UIGestureRecognizer;
/**
 *  添加一个点击手势
 *
 *  @param target 目标
 *  @param action 动作
 */
-(void )addTapGestureWithTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer  *gesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}


/**
 添加一个拖拽收拾
 
 @param target 目标
 @param action 动作
 */
-(void)addPanGestureWithTarget:(id)target action:(SEL)action{
    UIPanGestureRecognizer  *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}


/**
 添加一个长按手势
 
 @param target 目标
 @param action 动作
 */
-(void)addLongGestureWithTarget:(id)target action:(SEL)action{
    UILongPressGestureRecognizer  *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}


/**
 移除所有的手势
 */
-(void)removeAllGesture{
    NSArray *gustures = self.gestureRecognizers;
    if(gustures.count>0){
        for (UIGestureRecognizer *g in gustures) {
            [self removeGestureRecognizer:g];
        }
    }
}

#pragma mark - Animation

/**
 *  缩放动画
 *
 *  @param duration   动画周期
 *  @param completion 动画完成后的回调
 */
- (void)zoomAminationDuration:(NSTimeInterval)duration
                   completion:(void (^)(BOOL))completion{
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}


/**
 *  淡入动画
 *
 *  @param duration   动画周期
 *  @param completion 动画完成后的回调
 */
- (void)fadeInAnimationDuration:(NSTimeInterval)duration
                     completion:(void (^)(BOOL))completion{
    [self setAlpha:0.0];
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}


/**
 *  淡出动画
 *
 *  @param duration   动画周期
 *  @param completion 动画完成后的回调
 */
- (void)fadeOutAnimationDuration:(NSTimeInterval)duration
                      completion:(void (^)(BOOL))completion{
    [self setAlpha:1.0];
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

/**
 *  下移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveDownAnimationDuration:(NSTimeInterval)duration
                       moveLenth:(CGFloat)lenth
                      completion:(void (^)(BOOL))completion{
    [UIView animateWithDuration:duration animations:^{
        self.center = CGPointMake(self.x, self.y + lenth);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}


/**
 *  上移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveUpAnimationDuration:(NSTimeInterval)duration
                     moveLenth:(CGFloat)lenth
                    completion:(void (^)(BOOL))completion{
    [UIView animateWithDuration:duration animations:^{
        self.center = CGPointMake(self.x, self.y - lenth);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}


/**
 *  左移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveLeftAnimationDuration:(NSTimeInterval)duration
                       moveLenth:(CGFloat)lenth
                      completion:(void (^)(BOOL))completion{
    [UIView animateWithDuration:duration animations:^{
        self.center = CGPointMake(self.x - lenth, self.y);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}


/**
 *  右移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveRightAnimationDuration:(NSTimeInterval)duration
                        moveLenth:(CGFloat)lenth
                       completion:(void (^)(BOOL))completion{
    [UIView animateWithDuration:duration animations:^{
        self.center = CGPointMake(self.x + lenth, self.y);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}


/**
 *  旋转动画
 *
 *  @param duration   动画周期
 *  @param angle      旋转角度
 *  @param completion 完成后的回调
 */
-(void)rotateAnimationDuration:(NSTimeInterval)duration
                   ratateAngle:(CGFloat)angle
                    completion:(void (^)(BOOL))completion{
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeRotation((M_PI * (angle)) / 180.0);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

/**
 *  翻转动画
 *
 *  @param duration 翻转周期
 *  @param toView   翻转之后的视图
 *  @param recover  是否恢复
 */
-(void)flipAnimationDuration:(NSTimeInterval)duration toView:(UIView *)toView recover:(BOOL)recover{
    [UIView transitionFromView:self toView:toView duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut completion:^(BOOL finished) {
        if (recover) {
            
        }
    }];
}


/**
 *  转场动画
 *
 *  @param duration 转场动画周期
 *  @param fromView 从那个视图
 *  @param toView   到那个视图
 *  @param options  转场动画设置选项
 */
-(void)transformAnimtaionDuration:(NSTimeInterval)duration
                         fromView:(UIView *)fromView
                           toView:(UIView *)toView
                          options:(UIViewAnimationOptions)options{
    [UIView transitionWithView:self duration:duration options:options animations:^{
        if (fromView.hidden) {
            fromView.hidden = NO;
            toView.hidden = YES;
            
        } else {
            fromView.hidden = YES;
            toView.hidden = NO;
        }
    } completion:^(BOOL finished) {
        
    }];
}


/**
 *  翻页动画效果(左右是翻转动画，上下是翻页动画)
 *
 *  @param duration   动画时间
 *  @param curve      翻页动画曲线
 *  @param transition 翻页动画过度方向
 *  @param completion 完成动画后的回调
 */
-(void)flipoverAnimtationDuration:(NSTimeInterval)duration
                            curve:(UIViewAnimationCurve)curve
                       transition:(UIViewAnimationTransition)transition
                       completion:(void (^)(BOOL finished))completion{
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:curve];
        [UIView setAnimationTransition:transition forView:self cache:YES];
    }completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}




/**
 *  淡入淡出效果
 *
 *  @param duration  动画时间
 *  @param completion 完成后的回调
 */
-(void)fadeOutfadeInDuration:(NSTimeInterval)duration
                  completion:(void (^)(BOOL finished))completion{
    [UIView animateWithDuration:duration/2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/2 animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    }];
}


/**
 *  创建圆形层
 *
 *  @param position 从指定点
 *  @param rect     矩形范围
 *  @param radius   半径
 *
 *  @return 返回图形层
 */
- (CAShapeLayer *)createCircleShapeWithPosition:(CGPoint)position pathRect:(CGRect)rect radius:(CGFloat)radius type:(USRippleAnimationType)type flashColor:(UIColor *)flashColor{
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;
    circleShape.position = position;
    
    if (type == USRippleAnimationInner) {
        circleShape.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
        circleShape.fillColor = flashColor ? flashColor.CGColor : [UIColor whiteColor].CGColor;
    } else {
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.strokeColor = flashColor ? flashColor.CGColor : [UIColor purpleColor].CGColor;
    }
    
    circleShape.opacity = 0;
    circleShape.lineWidth = 1;
    
    return circleShape;
}




#pragma mark - 布局相关
/**
 *  向自己身上添加数组的所有视图
 *
 *  @param subViews 子类视图数组
 */
-(void)addSubviews:(NSArray *)subViews{
    [subViews enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }];
}









#pragma mark -辉光相关


- (void)createGlowLayer {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:self.bounds];
    [[self accessGlowColor] setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
    
    self.glowLayer               = [CALayer layer];
    self.glowLayer.frame         = self.bounds;
    self.glowLayer.contents      = (__bridge id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    self.glowLayer.opacity       = 0.f;
    self.glowLayer.shadowOffset  = CGSizeMake(0, 0);
    self.glowLayer.shadowOpacity = 1.f;
    
    UIGraphicsEndImageContext();
}

- (void)insertGlowLayer {
    
    if (self.glowLayer) {
        
        [self.layer addSublayer:self.glowLayer];
    }
}

- (void)removeGlowLayer {
    
    if (self.glowLayer) {
        
        [self.glowLayer removeFromSuperlayer];
    }
}

- (void)glowToshowAnimated:(BOOL)animated {
    
    self.glowLayer.shadowColor   = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius  = [self accessGlowRadius].floatValue;
    
    if (animated) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue         = @(0.f);
        animation.toValue           = [self accessGlowOpacity];
        self.glowLayer.opacity      = [self accessGlowOpacity].floatValue;
        animation.duration          = [self accessAnimationDuration].floatValue;
        
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
        
    } else {
        
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = [self accessGlowOpacity].floatValue;
    }
}

- (void)glowToHideAnimated:(BOOL)animated {
    
    self.glowLayer.shadowColor   = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius  = [self accessGlowRadius].floatValue;
    
    if (animated) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue         = [self accessGlowOpacity];
        animation.toValue           = @(0.f);
        self.glowLayer.opacity      = 0.f;
        animation.duration          = [self accessAnimationDuration].floatValue;
        
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
        
    } else {
        
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = 0.f;
    }
}

- (void)startGlowLoop {
    
    if (self.dispatchSource == nil) {
        
        CGFloat seconds      = [self accessAnimationDuration].floatValue * 2 + [self accessGlowDuration].floatValue + [self accessHideDuration].floatValue;
        CGFloat delaySeconds = [self accessAnimationDuration].floatValue + [self accessGlowDuration].floatValue;
        
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        
        __weak UIView *weakSelf = self;
        dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC * seconds, 0);
        dispatch_source_set_event_handler(self.dispatchSource, ^{
            
            [weakSelf glowToshowAnimated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delaySeconds), dispatch_get_main_queue(), ^{
                
                [weakSelf glowToHideAnimated:YES];
            });
        });
        
        dispatch_resume(self.dispatchSource);
    }
}


/**
 *  动态方位的动画
 */
- (void)motionAnimation{
    // Motion effects are available starting from iOS 7.
    if (([[[UIDevice currentDevice] systemVersion] compare:@"7.0"
                                                   options:NSNumericSearch] != NSOrderedAscending))
    {
        
        UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                        type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalEffect.minimumRelativeValue = @(-10.0f);
        horizontalEffect.maximumRelativeValue = @( 10.0f);
        UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                      type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalEffect.minimumRelativeValue = @(-10.0f);
        verticalEffect.maximumRelativeValue = @( 10.0f);
        UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
        motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
        
        [self addMotionEffect:motionEffectGroup];
    }
}

/**
 *  心跳动画
 */
- (void)heartbeatAnimation:(CGFloat)scale
                  duration:(NSTimeInterval)duration
                    repeat:(BOOL)repeat{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pulseAnimation.duration = duration;
    pulseAnimation.toValue = [NSNumber numberWithFloat:scale];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = repeat ? HUGE_VALF : 0;
    
    [self.layer addAnimation:pulseAnimation
                      forKey:@"pulse"];
}



- (void)flipWithDuration:(NSTimeInterval)duration
               direction:(UIViewAnimationFlipDirection)direction
             repeatCount:(NSUInteger)repeatCount
             autoreverse:(BOOL)shouldAutoreverse
{
    NSString *subtype = nil;
    
    switch (direction)
    {
            case UIViewAnimationFlipDirectionFromTop:
            subtype = @"fromTop";
            break;
            case UIViewAnimationFlipDirectionFromLeft:
            subtype = @"fromLeft";
            break;
            case UIViewAnimationFlipDirectionFromBottom:
            subtype = @"fromBottom";
            break;
            case UIViewAnimationFlipDirectionFromRight:
        default:
            subtype = @"fromRight";
            break;
    }
    
    CATransition *transition = [CATransition animation];
    
    transition.startProgress = 0.0f;
    transition.endProgress = 1.0f;
    transition.type = @"flip";
    transition.subtype = subtype;
    transition.duration = duration;
    transition.repeatCount = repeatCount;
    transition.autoreverses = shouldAutoreverse;
    
    [self.layer addAnimation:transition
                      forKey:@"spin"];
}


- (void)rotateToAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
            direction:(UIViewAnimationRotationDirection)direction
          repeatCount:(NSUInteger)repeatCount
          autoreverse:(BOOL)shouldAutoreverse;
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = @(direction == UIViewAnimationRotationDirectionRight ? angle : -angle);
    rotationAnimation.duration = duration;
    rotationAnimation.autoreverses = shouldAutoreverse;
    rotationAnimation.repeatCount = repeatCount;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:rotationAnimation
                      forKey:@"transform.rotation.z"];
}


- (void)stopAnimation
{
    [CATransaction begin];
    [self.layer removeAllAnimations];
    [CATransaction commit];
    
    [CATransaction flush];
}


- (BOOL)isBeingAnimated
{
    return [self.layer.animationKeys count];
}

#pragma mark - 处理数据越界问题

- (NSNumber *)accessGlowOpacity {
    
    if (self.glowOpacity) {
        
        if (self.glowOpacity.floatValue <= 0 || self.glowOpacity.floatValue > 1) {
            
            return @(0.8);
            
        } else {
            
            return self.glowOpacity;
        }
        
    } else {
        
        return @(0.8);
    }
}

- (NSNumber *)accessGlowDuration {
    
    if (self.glowDuration) {
        
        if (self.glowDuration.floatValue <= 0) {
            
            return @(0.5f);
            
        } else {
            
            return self.glowDuration;
        }
        
    } else {
        
        return @(0.5f);
    }
}

- (NSNumber *)accessHideDuration {
    
    if (self.hideDuration) {
        
        if (self.hideDuration.floatValue < 0) {
            
            return @(0.5);
            
        } else {
            
            return self.hideDuration;
        }
        
    } else {
        
        return @(0.5f);
    }
}

- (NSNumber *)accessAnimationDuration {
    
    if (self.glowAnimationDuration) {
        
        if (self.glowAnimationDuration.floatValue <= 0) {
            
            return @(1.f);
            
        } else {
            
            return self.glowAnimationDuration;
        }
        
    } else {
        
        return @(1.f);
    }
}

- (UIColor *)accessGlowColor {
    
    if (self.glowColor) {
        
        return self.glowColor;
        
    } else {
        
        return [UIColor redColor];
    }
}

- (NSNumber *)accessGlowRadius {
    
    if (self.glowRadius) {
        
        if (self.glowRadius.floatValue <= 0) {
            
            return @(2.f);
            
        } else {
            
            return self.glowRadius;
        }
        
    } else {
        
        return @(2.f);
    }
}

#pragma mark - runtime属性

- (void)setDispatchSource:(dispatch_source_t)dispatchSource {
    
    objc_setAssociatedObject(self, @selector(dispatchSource), dispatchSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)dispatchSource {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowColor:(UIColor *)glowColor {
    
    objc_setAssociatedObject(self, @selector(glowColor), glowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)glowColor {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowOpacity:(NSNumber *)glowOpacity {
    
    objc_setAssociatedObject(self, @selector(glowOpacity), glowOpacity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowOpacity {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowRadius:(NSNumber *)glowRadius {
    
    objc_setAssociatedObject(self, @selector(glowRadius), glowRadius, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowRadius {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowAnimationDuration:(NSNumber *)glowAnimationDuration {
    
    objc_setAssociatedObject(self, @selector(glowAnimationDuration), glowAnimationDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowAnimationDuration {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowDuration:(NSNumber *)glowDuration {
    
    objc_setAssociatedObject(self, @selector(glowDuration), glowDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowDuration {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHideDuration:(NSNumber *)hideDuration {
    
    objc_setAssociatedObject(self, @selector(hideDuration), hideDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)hideDuration {
    
    return objc_getAssociatedObject(self, _cmd);
}

NSString * const _recognizerGlowLayer = @"_recognizerGlowLayer";

- (void)setGlowLayer:(CALayer *)glowLayer {
    
    objc_setAssociatedObject(self, @selector(glowLayer), glowLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)glowLayer {
    
    return objc_getAssociatedObject(self, _cmd);
}


@end
