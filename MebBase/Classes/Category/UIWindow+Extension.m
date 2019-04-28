//
//  UIWindow+Extension.m
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

#import "UIWindow+Extension.h"
#import "UIImage+Extension.h"      //这里有一个依赖，最好不要做依赖

#define kBlurEffectViewTag 19871026

@implementation UIWindow (Extension)

/**
 *  获取到根窗口
 *
 *  @return 返回根窗口
 */
+ (UIWindow *)baseWindow{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (!window)
        window = [[UIApplication sharedApplication] keyWindow];
    NSAssert(window != nil, @"层级列表中没有根窗口!");
    return window;
}


/**
 *  获取最顶端的视图控制器
 *
 *  @return 返回最顶端的视图控制器
 */
+ (UIViewController *)topMostViewController{
    return [self topmostViewControllerFrom:[[self baseWindow] rootViewController] includeModal:YES];
}

/**
 *  获取最顶端的导航控制器
 *
 *  @return 返回最顶端的导航控制器
 */
+ (UINavigationController *)topMostNavigationController{
    return [self topmostNavigationControllerFrom:[self topMostViewController]];
}


/**
 *  获取到最顶端的非modal形式的视图控制器
 *
 *  @return 返回最顶端的视图控制器
 */
+ (UIViewController *)topMostNonModalViewController{
    return [self topmostViewControllerFrom:[[self baseWindow] rootViewController] includeModal:NO];
}


/**
 *  获取某个视图的最顶层导航控制器
 *
 *  @param vc 指定的视图控制器
 *
 *  @return 返回该视图控制器最顶端的导航控制器
 */
+ (UINavigationController *)topmostNavigationControllerFrom:(UIViewController *)vc{
    if ([vc isKindOfClass:[UINavigationController class]])
        return (UINavigationController *)vc;
    if ([vc navigationController])
        return [vc navigationController];
    if (vc.presentingViewController)
        return [self topmostNavigationControllerFrom:vc.presentingViewController];
    else
        return nil;
}


/**
 *  获取指定视图的最顶端的视图控制器
 *
 *  @param viewController 指定的视图控制器
 *  @param includeModal   是否包含modal形式的视图
 *
 *  @return 返回最顶端的视图控制器
 */
+ (UIViewController *)topmostViewControllerFrom:(UIViewController *)viewController
                                   includeModal:(BOOL)includeModal{
    if (includeModal && viewController.presentedViewController)
        return [self topmostViewControllerFrom:viewController.presentedViewController
                                  includeModal:includeModal];
    if ([viewController respondsToSelector:@selector(topViewController)])
        return [self topmostViewControllerFrom:[(id)viewController topViewController]
                                  includeModal:includeModal];
    return viewController;
}


/**
 *  切换根视图控制器
 *
 *  @abstract 在该方法中获取版本号码，然后通过比较版本号码来切换新特性视图
 */
- (void)switchRootViewController{
//    需要重写，切换提供外部去切换而不是在内部切换，稍后去做block回调提供外部执行
//    if([MBAccountTool hadLogin]){
//        [self switchMainController];
//    }else{
//        [self switchLoginController];
//    }
}


/**
 *  切换根视图到登录控制器
 */
- (void)switchLoginController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    self.rootViewController = [storyboard instantiateInitialViewController];
}

/**
 *  切换根视图到新特性控制器
 */
- (void)switchMainController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.rootViewController = [storyboard instantiateInitialViewController];
}


/**
 *  显示登录闪图
 *
 *  @TODO 需要修正
 */
+ (void)showSplashView{
    UIImageView *splashImageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    splashImageView.image = [UIImage imageNamed:@"LacnchImage"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:splashImageView];
    [UIView animateWithDuration:1.5f delay:1.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        splashImageView.alpha = 0.0f;
        splashImageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2f, 1.2f, 1.0f);
    } completion:^(BOOL finished) {
        [splashImageView removeFromSuperview];
    }];
    
    /*
     #warning 或者去做window界面跳转，这个配合luachiamgexib或者story去做登录界面，展示之后跳转界面
     splashImageView.alpha = 0.5;
     [UIView animateWithDuration:3
     animations:^{
     splashImageView.alpha = 1.0;
     splashImageView.transform = CGAffineTransformMakeScale(1.15, 1.15);
     } completion:^(BOOL finished) {
     [splashImageView removeFromSuperview];
     }];
     */
}



/**
 *  添加模糊效果，主要用户应用进入后台
 */
+ (void)addBlurEffect{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.tag = kBlurEffectViewTag;
    imageView.image = [[UIImage screenShot]imgWithBlur];
    [[[UIApplication sharedApplication] keyWindow] addSubview:imageView];
}


/**
 *  移除模糊效果，主要用于应用进入前台
 */
+ (void)removeBlurEffect{
    NSArray *subViews = [[UIApplication sharedApplication] keyWindow].subviews;
    for (id object in subViews) {
        if ([[object class] isSubclassOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)object;
            if(imageView.tag == kBlurEffectViewTag){
                [UIView animateWithDuration:0.5 animations:^{
                    imageView.alpha = 0;
                    [imageView removeFromSuperview];
                }];
            }
        }
    }
}

@end
