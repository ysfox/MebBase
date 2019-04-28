//
//  UIView+Extension.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, USRippleAnimationType) {
    USRippleAnimationInner = 0,                     //内部闪光
    USFlashButtonTypeOuter = 1                      //外部闪光
};

/**
 @brief Direction of flip animation.
 */
typedef NS_ENUM(NSUInteger, UIViewAnimationFlipDirection)
{
    UIViewAnimationFlipDirectionFromTop,
    UIViewAnimationFlipDirectionFromLeft,
    UIViewAnimationFlipDirectionFromRight,
    UIViewAnimationFlipDirectionFromBottom,
};


/**
 @brief Direction of rotation animation.
 */
typedef NS_ENUM(NSUInteger, UIViewAnimationRotationDirection)
{
    UIViewAnimationRotationDirectionRight,
    UIViewAnimationRotationDirectionLeft
};

@interface UIView (Extension)


/*----------------------
 * Absolute coordinate *
 ----------------------*/

/** 视图的x属性set和get方法 */
@property(nonatomic,assign)CGFloat x;
/** 视图的y属性set和get方法 */
@property(nonatomic,assign)CGFloat y;
/** 视图的中心点x属性set和get方法 */
@property(nonatomic,assign)CGFloat cX;
/** 视图的中心点y属性set和get方法 */
@property(nonatomic,assign)CGFloat cY;
/** 视图的宽度set和get方法 */
@property(nonatomic,assign)CGFloat w;
/** 视图的高度set和get方法 */
@property(nonatomic,assign)CGFloat h;
/** 视图的坐标点set和get方法 */
@property(nonatomic,assign)CGPoint o;
/** 视图的尺寸set和get方法 */
@property(nonatomic,assign)CGSize size;

@property (nonatomic) CGFloat t;
@property (nonatomic) CGFloat b;
@property (nonatomic) CGFloat l;
@property (nonatomic) CGFloat r;



/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat minX;
@property (nonatomic, readonly) CGFloat minY;
@property (nonatomic, readonly) CGFloat maxX;
@property (nonatomic, readonly) CGFloat maxY;

#pragma mark - AnimationProperty

/**
 *  CGAffineTransformMakeScale
 */
@property (nonatomic) CGFloat  scale;

/**
 *  CGAffineTransformMakeRotation
 */
@property (nonatomic) CGFloat  angle;





/**
 *  从Xib中加载一个控件出来（Xib的名字和类名一致）
 */
+ (instancetype)viewFromXib;

/**
 *  从Xib中加载一个控件
 *
 *  @param nibName nib名字
 *
 *  @return 返回视图控件
 */
+ (instancetype)viewWithNibName:(NSString* )nibName;


/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

/**
 *  视图上是否包含指定的点
 *
 *  @param point 指定的点
 *
 *  @return 返回是否包含这点
 */
- (BOOL)containsPoint:(CGPoint)point;

/**
 *  视图上是否包含指定的矩形
 *
 *  @param rect 指定的点
 *
 *  @return 返回判断结果
 */
- (BOOL)containsRect:(CGRect)rect;


/**
 *  深度挖掘视图的层次结构
 *
 *  @return 返回遍历到的视图层次结构
 *  @abstract 这个方法主要用于查看某个视图的层数结构,是一段xml
 */
- (NSString *)digView;


/**
 *  深度给视图的层级视图作色
 */
- (void)digViewColor;


/**
 *  截屏方法2(截取当前视图的屏幕)
 *
 *  @return 截屏的图片
 */
- (UIImage *)viewShot;


/* 指定圆角大小处理 */
- (void)cornerRadius:(CGFloat)radius;

/* 添加border */
- (void)borderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/* 指定圆角大小，且带border */
- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

/* 对UIView的四个角进行选择性的圆角处理 */
- (void)makeRoundedCorner:(UIRectCorner)byRoundingCorners cornerRadii:(CGSize)cornerRadii;


/**
 *  隐藏UI控件上的指定名称的所有视图,主要针对于苹果的私有APIUI组件
 *
 *  @param suffix 指定要隐藏的UI控件的后缀名称
 *
 *  @return 返回是否隐藏成功
 */
- (BOOL)hiddenPrivUI:(NSString *)suffix;


/**
 *  获取视图上的指定的名称的视图，主要针对于苹果的死于哦APIUI组件
 *
 *  @param subffix 指定的需要获取的UI空间的后缀
 *
 *  @warnning 注意这个返回的视图不能确定到具体的点上，需要从长计议
 *  @return 返回对应的视图
 */
- (UIView *)getPrivUI:(NSString *)subffix;


/**
 *  获取到视图上指定名称的所有视图，主要正对于苹果的四有APIUI组件
 *
 *  @param subffix 指定的需要获取的UI空间的后最
 *
 *  @return 返回对应的视图数组
 */
- (NSArray *)getPrivUIs:(NSString *)subffix;


/**
 *  获取视图所在的视图控制器
 *
 *  @return 返回获取到的视图控制器
 */
- (UIViewController *)parentViewController;


/**
 *  设置主题
 *
 *  @param containerClass 容器视图类
 *
 *  @return 返回实例化对象
 */
+ (instancetype)lt_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;



#pragma mark -  UIGestureRecognizer;
/**
 *  添加一个点击手势
 *
 *  @param target 目标
 *  @param action 动作
 */
-(void)addTapGestureWithTarget:(id)target action:(SEL)action;


/**
 添加一个拖拽收拾
 
 @param target 目标
 @param action 动作
 */
-(void)addPanGestureWithTarget:(id)target action:(SEL)action;



/**
 添加一个长按手势
 
 @param target 目标
 @param action 动作
 */
-(void)addLongGestureWithTarget:(id)target action:(SEL)action;


/**
 移除所有的手势
 */
-(void)removeAllGesture;

#pragma mark - Animation

/**
 *  缩放动画
 *
 *  @param duration   动画周期
 *  @param completion 动画完成后的回调
 */
- (void)zoomAminationDuration:(NSTimeInterval)duration
                   completion:(void (^)(BOOL))completion;

/**
 *  淡入动画
 *
 *  @param duration   动画周期
 *  @param completion 动画完成后的回调
 */
- (void)fadeInAnimationDuration:(NSTimeInterval)duration
                     completion:(void (^)(BOOL))completion;


/**
 *  淡出动画
 *
 *  @param duration   动画周期
 *  @param completion 动画完成后的回调
 */
- (void)fadeOutAnimationDuration:(NSTimeInterval)duration
                      completion:(void (^)(BOOL))completion;


/**
 *  下移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveDownAnimationDuration:(NSTimeInterval)duration
                       moveLenth:(CGFloat)lenth
                      completion:(void (^)(BOOL))completion;


/**
 *  上移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveUpAnimationDuration:(NSTimeInterval)duration
                     moveLenth:(CGFloat)lenth
                    completion:(void (^)(BOOL))completion;


/**
 *  左移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveLeftAnimationDuration:(NSTimeInterval)duration
                       moveLenth:(CGFloat)lenth
                      completion:(void (^)(BOOL))completion;


/**
 *  右移动画
 *
 *  @param duration   动画周期
 *  @param lenth      移动步长
 *  @param completion 动画完成后的回调
 */
-(void)moveRightAnimationDuration:(NSTimeInterval)duration
                        moveLenth:(CGFloat)lenth
                       completion:(void (^)(BOOL))completion;


/**
 *  旋转动画
 *
 *  @param duration   动画周期
 *  @param angle      旋转角度
 *  @param completion 完成后的回调
 */
-(void)rotateAnimationDuration:(NSTimeInterval)duration
                   ratateAngle:(CGFloat)angle
                    completion:(void (^)(BOOL))completion;


/**
 *  翻转动画
 *
 *  @param duration 翻转周期
 *  @param toView   翻转之后的视图
 *  @param recover  是否恢复
 */
-(void)flipAnimationDuration:(NSTimeInterval)duration
                      toView:(UIView *)toView
                     recover:(BOOL)recover;


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
                          options:(UIViewAnimationOptions)options;



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
                       completion:(void (^)(BOOL finished))completion;



/**
 *  淡入淡出效果
 *
 *  @param duration  动画时间
 *  @param completion 完成后的回调
 */
-(void)fadeOutfadeInDuration:(NSTimeInterval)duration
                  completion:(void (^)(BOOL finished))completion;






/**
 *  动态方位的动画
 */
- (void)motionAnimation;



/**
 *  心跳动画
 *
 *  @param scale    缩放值，建议1.1f
 *  @param duration 心跳动画时间，建议0.3f
 *  @param repeat   是否重复，当然重复
 */
- (void)heartbeatAnimation:(CGFloat)scale
                  duration:(NSTimeInterval)duration
                    repeat:(BOOL)repeat;



/**
 @brief Performs a 3D-like flip animation of the view around center X or Y axis.
 @param duration - total time of the animation.
 @param direction - direction of the flip movement.
 @param repeatCount - number of repetitions of the animation. Pass HUGE_VALF to repeat forever.
 @param shouldAutoreverse - pass YES to make the animation reverse when it reaches the end.
 */
- (void)flipWithDuration:(NSTimeInterval)duration
               direction:(UIViewAnimationFlipDirection)direction
             repeatCount:(NSUInteger)repeatCount
             autoreverse:(BOOL)shouldAutoreverse;


/**
 @brief Performs a rotation animation of the view around its anchor point.
 @param angle - end angle of the rotation. Pass M_PI * 2.0 for full circle rotation.
 @param duration - total time of the animation.
 @param direction - left or right direction of the rotation.
 @param repeatCount - number of repetitions of the animation. Pass HUGE_VALF to repeat forever.
 @param shouldAutoreverse - pass YES to make the animation reverse when it reaches the end.
 */
- (void)rotateToAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
            direction:(UIViewAnimationRotationDirection)direction
          repeatCount:(NSUInteger)repeatCount
          autoreverse:(BOOL)shouldAutoreverse;


/**
 @brief Stops current animations.
 */
- (void)stopAnimation;


/**
 @brief Checks if the view is being animated.
 */
- (BOOL)isBeingAnimated;

#pragma mark - 布局相关
/**
 *  向自己身上添加数组的所有视图
 *
 *  @param subViews 子类视图数组
 */
-(void)addSubviews:(NSArray *)subViews;






#pragma mark - 辉光
//
//                                     == 动画时间解析 ==
//
//  0.0 ------------- 0.0 ------------> glowOpacity [-------------] glowOpacity ------------> 0.0
//           T                 T                           T                          T
//           |                 |                           |                          |
//           |                 |                           |                          |
//           .                 .                           .                          .
//     hideDuration  glowAnimationDuration           glowDuration            glowAnimationDuration
//

#pragma mark - 设置辉光效果

/**
 *  辉光的颜色
 */
@property (nonatomic, strong) UIColor  *glowColor;

/**
 *  辉光的透明度
 */
@property (nonatomic, strong) NSNumber *glowOpacity;

/**
 *  辉光的阴影半径
 */
@property (nonatomic, strong) NSNumber *glowRadius;

#pragma mark - 设置辉光时间间隔

/**
 *  一次完整的辉光周期（从显示到透明或者从透明到显示），默认1s
 */
@property (nonatomic, strong) NSNumber *glowAnimationDuration;

/**
 *  保持辉光时间（不设置，默认为0.5s）
 */
@property (nonatomic, strong) NSNumber *glowDuration;

/**
 *  不显示辉光的周期（不设置默认为0.5s）
 */
@property (nonatomic, strong) NSNumber *hideDuration;

#pragma mark - 辉光相关操作

/**
 *  创建出辉光layer
 */
- (void)createGlowLayer;

/**
 *  插入辉光的layer
 */
- (void)insertGlowLayer;

/**
 *  移除辉光的layer
 */
- (void)removeGlowLayer;

/**
 *  显示辉光
 */
- (void)glowToshowAnimated:(BOOL)animated;

/**
 *  隐藏辉光
 */
- (void)glowToHideAnimated:(BOOL)animated;

/**
 *  开始循环辉光
 */
- (void)startGlowLoop;

@end

