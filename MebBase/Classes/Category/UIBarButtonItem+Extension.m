//
//  UIBarButtonItem+Extension.m
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

#import "UIBarButtonItem+Extension.h"
#import <objc/runtime.h>

/** 徽章标识 */
NSString const *UIBarButtonItem_badgeKey = @"UIBarButtonItem_badgeKey";
/** 背景颜色标识 */
NSString const *UIBarButtonItem_badgeBGColorKey = @"UIBarButtonItem_badgeBGColorKey";
/** 文本颜色标识 */
NSString const *UIBarButtonItem_badgeTextColorKey = @"UIBarButtonItem_badgeTextColorKey";
/** 徽章字体标识 */
NSString const *UIBarButtonItem_badgeFontKey = @"UIBarButtonItem_badgeFontKey";
/** 徽章间距标识 */
NSString const *UIBarButtonItem_badgePaddingKey = @"UIBarButtonItem_badgePaddingKey";
/** 徽章最小尺寸标识 */
NSString const *UIBarButtonItem_badgeMinSizeKey = @"UIBarButtonItem_badgeMinSizeKey";
/** 徽章X偏移标识 */
NSString const *UIBarButtonItem_badgeOriginXKey = @"UIBarButtonItem_badgeOriginXKey";
/** 徽章Y偏移标识 */
NSString const *UIBarButtonItem_badgeOriginYKey = @"UIBarButtonItem_badgeOriginYKey";
/** 徽章为0是是否自动隐藏标识 */
NSString const *UIBarButtonItem_shouldHideBadgeAtZeroKey = @"UIBarButtonItem_shouldHideBadgeAtZeroKey";
/** 徽章是否动画标识 */
NSString const *UIBarButtonItem_shouldAnimateBadgeKey = @"UIBarButtonItem_shouldAnimateBadgeKey";
/** 徽章内容标识 */
NSString const *UIBarButtonItem_badgeValueKey = @"UIBarButtonItem_badgeValueKey";

@implementation UIBarButtonItem (Extension)

@dynamic badgeValue, badgeBGColor, badgeTextColor, badgeFont;
@dynamic badgePadding, badgeMinSize, badgeOriginX, badgeOriginY;
@dynamic shouldHideBadgeAtZero, shouldAnimateBadge;

/**
 *  开始初始化
 */
- (void)badgeInit{
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.badge.frame.size.width/2;
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.badge.frame.size.width;
    }
    [superview addSubview:self.badge];
    
    self.badgeBGColor   = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont      = [UIFont systemFontOfSize:12.0];
    self.badgePadding   = 6;
    self.badgeMinSize   = 8;
    self.badgeOriginX   = defaultOriginX;
    self.badgeOriginY   = -4;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
}

#pragma mark - Utility methods
/**
 *  当徽章属性改变了处理现实徽章
 */
- (void)refreshBadge{
    // Change new attributes
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
    
    if (!self.badgeValue || [self.badgeValue isEqualToString:@""] || ([self.badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        self.badge.hidden = YES;
    } else {
        self.badge.hidden = NO;
        [self updateBadgeValueAnimated:YES];
    }
}

/**
 *  更新徽章内容，
 *
 *  @param animated 是否通过动画的方式更新
 */
- (void)updateBadgeValueAnimated:(BOOL)animated{
    if (animated && self.shouldAnimateBadge && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    self.badge.text = self.badgeValue;
    if (animated && self.shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self updateBadgeFrame];
        }];
    } else {
        [self updateBadgeFrame];
    }
}



/**
 *  更新徽章尺寸
 */
- (void)updateBadgeFrame{
    
    CGSize expectedLabelSize = [self badgeExpectedSize];
    CGFloat minHeight = expectedLabelSize.height;
    
    minHeight = (minHeight < self.badgeMinSize) ? self.badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.badgePadding;
    
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.badge.layer.masksToBounds = YES;
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
    self.badge.layer.cornerRadius = (minHeight + padding) / 2;
}

/**
 *  徽章扩展尺寸
 *
 *  @return 返回扩展的尺寸
 */
- (CGSize)badgeExpectedSize{
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}


/**
 *  复制lable，通过新建立的label获取到label内容的尺寸
 *
 *  @param labelToCopy 原来的label
 *
 *  @return 返回复制的label
 */
- (UILabel *)duplicateLabel:(UILabel *)labelToCopy{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    return duplicateLabel;
}


/**
 *  移除徽章
 */
- (void)removeBadge{
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters/setters
/**
 *  获取徽章标签
 *
 *  @return 徽章标签
 */
-(UILabel*)badge{
    UILabel* lbl = objc_getAssociatedObject(self, &UIBarButtonItem_badgeKey);
    if(lbl==nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        [self setBadge:lbl];
        [self badgeInit];
        [self.customView addSubview:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    return lbl;
}

/**
 *  设置徽章标签
 *
 *  @param badgeLabel 徽章标签
 */
-(void)setBadge:(UILabel *)badgeLabel{
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 *  获取徽章的内容
 *
 *  @return 获取徽章的内容
 */
-(NSString *)badgeValue{
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeValueKey);
}

/**
 *  设置徽章内容，当内容改变的时候动画更新内容并刷新徽章
 *
 *  @param badgeValue 徽章内容
 */
-(void)setBadgeValue:(NSString *)badgeValue{
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBadgeValueAnimated:YES];
    [self refreshBadge];
}

/**
 *  获取徽章背景颜色
 *
 *  @return 返回徽章背景颜色
 */
-(UIColor *)badgeBGColor{
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeBGColorKey);
}

/**
 *  设置徽章背景颜色
 *
 *  @param badgeBGColor 徽章背景颜色
 */
-(void)setBadgeBGColor:(UIColor *)badgeBGColor{
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

/**
 *  获取徽章文字颜色
 *
 *  @return 徽章文字颜色
 */
-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeTextColorKey);
}

/**
 *  设置徽章文字颜色
 *
 *  @param badgeTextColor 徽章文字颜色
 */
-(void)setBadgeTextColor:(UIColor *)badgeTextColor{
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

/**
 *  获取徽章字体
 *
 *  @return 返回徽章字体
 */
-(UIFont *)badgeFont{
    return objc_getAssociatedObject(self, &UIBarButtonItem_badgeFontKey);
}

/**
 *  设置徽章字体
 *
 *  @param badgeFont 徽章字体
 */
-(void)setBadgeFont:(UIFont *)badgeFont{
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

/**
 *  获取徽章间距
 *
 *  @return 返回徽章间距
 */
-(CGFloat)badgePadding{
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgePaddingKey);
    return number.floatValue;
}

/**
 *  设置徽章间距
 *
 *  @param badgePadding 徽章间距
 */
-(void)setBadgePadding:(CGFloat)badgePadding{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}


/**
 *  获取徽章最小尺寸
 *
 *  @return 返回徽章最小尺寸
 */
-(CGFloat)badgeMinSize{
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgeMinSizeKey);
    return number.floatValue;
}

/**
 *  设置徽章最小尺寸
 *
 *  @param badgeMinSize 徽章最小尺寸
 */
-(void) setBadgeMinSize:(CGFloat)badgeMinSize{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

/**
 *  获取徽章X偏移量
 *
 *  @return 返回X偏移量
 */
-(CGFloat)badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}

/**
 *  设置徽章X偏移量
 *
 *  @param badgeOriginX 徽章X偏移量
 */
-(void)setBadgeOriginX:(CGFloat)badgeOriginX{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

/**
 *  获取徽章X偏移量
 *
 *  @return 返回X偏移量
 */
-(CGFloat)badgeOriginY{
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}


/**
 *  设置徽章X偏移量
 *
 *  @param badgeOriginY 徽章Y偏移量
 */
-(void)setBadgeOriginY:(CGFloat)badgeOriginY{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}


/**
 *  获取徽章是否自动隐藏
 *
 *  @return 返回是否自动隐藏
 */
-(BOOL)shouldHideBadgeAtZero{
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}

/**
 *  设置徽章是否隐藏
 *
 *  @param shouldHideBadgeAtZero 是否隐藏
 */
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &UIBarButtonItem_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.badge) {
        [self refreshBadge];
    }
}

/**
 *  获取徽章是否动画
 *
 *  @return 返回是否动画
 */
-(BOOL)shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_shouldAnimateBadgeKey);
    return number.boolValue;
}

/**
 *  设置徽章是否动画
 *
 *  @param shouldAnimateBadge 是否动画
 */
- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &UIBarButtonItem_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.badge) {
        [self refreshBadge];
    }
}



#pragma mark - creater


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
                          highImage:(NSString *)highImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    return [[self alloc] initWithCustomView:btn];
}

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
                        selectImage:(NSString *)selectImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [btn sizeToFit];
    return [[self alloc] initWithCustomView:btn];
}


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
                      selectedTitle:(NSString *)selectedTitle{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
