//
//  UIButton+Extension.m
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

#import "UIButton+Extension.h"
#import "UIImage+Extension.h"
#import <objc/runtime.h>

/** 徽章标识 */
NSString const *UIButton_badgeKey = @"UIButton_badgeKey";
/** 背景颜色标识 */
NSString const *UIButton_badgeBGColorKey = @"UIButton_badgeBGColorKey";
/** 文本颜色标识 */
NSString const *UIButton_badgeTextColorKey = @"UIButton_badgeTextColorKey";
/** 徽章字体标识 */
NSString const *UIButton_badgeFontKey = @"UIButton_badgeFontKey";
/** 徽章间距标识 */
NSString const *UIButton_badgePaddingKey = @"UIButton_badgePaddingKey";
/** 徽章最小尺寸标识 */
NSString const *UIButton_badgeMinSizeKey = @"UIButton_badgeMinSizeKey";
/** 徽章X偏移标识 */
NSString const *UIButton_badgeOriginXKey = @"UIButton_badgeOriginXKey";
/** 徽章Y偏移标识 */
NSString const *UIButton_badgeOriginYKey = @"UIButton_badgeOriginYKey";
/** 徽章为0是是否自动隐藏标识 */
NSString const *UIButton_shouldHideBadgeAtZeroKey = @"UIButton_shouldHideBadgeAtZeroKey";
/** 徽章是否动画标识 */
NSString const *UIButton_shouldAnimateBadgeKey = @"UIButton_shouldAnimateBadgeKey";
/** 徽章内容标识 */
NSString const *UIButton_badgeValueKey = @"UIButton_badgeValueKey";


@implementation UIButton (Extension)

@dynamic badgeValue, badgeBGColor, badgeTextColor, badgeFont;
@dynamic badgePadding, badgeMinSize, badgeOriginX, badgeOriginY;
@dynamic shouldHideBadgeAtZero, shouldAnimateBadge;

/**
 *  开始初始化
 */
- (void)badgeInit{
    self.badgeBGColor   = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont      = [UIFont systemFontOfSize:12.0];
    self.badgePadding   = 6;
    self.badgeMinSize   = 8;
    self.badgeOriginX   = self.frame.size.width - self.badge.frame.size.width/2;
    self.badgeOriginY   = -4;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods
/**
 *  当徽章属性改变了处理现实徽章
 */
- (void)refreshBadge{
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
}

/**
 *  更新徽章尺寸
 */
- (CGSize)badgeExpectedSize{
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
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
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
    self.badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.badge.layer.masksToBounds = YES;
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
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self updateBadgeFrame];
    }];
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

-(UILabel*)badge{
    return objc_getAssociatedObject(self, &UIButton_badgeKey);
}
-(void)setBadge:(UILabel *)badgeLabel{
    objc_setAssociatedObject(self, &UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSString *)badgeValue{
    return objc_getAssociatedObject(self, &UIButton_badgeValueKey);
}
-(void) setBadgeValue:(NSString *)badgeValue{
    objc_setAssociatedObject(self, &UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        [self removeBadge];
    } else if (!self.badge) {
        self.badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        self.badge.textColor            = self.badgeTextColor;
        self.badge.backgroundColor      = self.badgeBGColor;
        self.badge.font                 = self.badgeFont;
        self.badge.textAlignment        = NSTextAlignmentCenter;
        [self badgeInit];
        [self addSubview:self.badge];
        [self updateBadgeValueAnimated:NO];
    } else {
        [self updateBadgeValueAnimated:YES];
    }
}


-(UIColor *)badgeBGColor{
    return objc_getAssociatedObject(self, &UIButton_badgeBGColorKey);
}
-(void)setBadgeBGColor:(UIColor *)badgeBGColor{
    objc_setAssociatedObject(self, &UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}


-(UIColor *)badgeTextColor{
    return objc_getAssociatedObject(self, &UIButton_badgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor{
    objc_setAssociatedObject(self, &UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}


-(UIFont *)badgeFont{
    return objc_getAssociatedObject(self, &UIButton_badgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont{
    objc_setAssociatedObject(self, &UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}


-(CGFloat) badgePadding{
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}


-(CGFloat) badgeMinSize{
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setBadgeMinSize:(CGFloat)badgeMinSize{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}


-(CGFloat) badgeOriginX{
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setBadgeOriginX:(CGFloat)badgeOriginX{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat)badgeOriginY{
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setBadgeOriginY:(CGFloat)badgeOriginY{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}


-(BOOL)shouldHideBadgeAtZero{
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(BOOL)shouldAnimateBadge{
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)startWithTimeInterval:(double)timeLine{
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = [UIColor whiteColor];
                [self setTitle:@"发送" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = [UIColor grayColor];
                [self setTitle:[NSString stringWithFormat:@"%@s",timeStr] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}


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
                      title:(NSString*)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    if (backImageName) {
        [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeCenter;
    
    [button addTarget: target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}


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
                       title:(NSString *)title{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.tag = tag;
    [button setBackgroundImage:[UIImage imageFromColor:normalBgColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageFromColor:selectedBgColor] forState:UIControlStateSelected];
    
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = YES;
    //    button.reversesTitleShadowWhenHighlighted = YES;
    //    button.showsTouchWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeCenter;
    
    [button addTarget: target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}





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
                       title:(NSString *)title{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = backGroundColor;
    button.tag = tag;
    //button.showsTouchWhenHighlighted = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.contentMode = UIViewContentModeCenter;
    
    [button addTarget: target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}



/**
 *  快速创建按钮
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
                       title:(NSString *)title{
    UIButton *btn = [self buttonWithFrame:frame normalBgColor:normalBackGroundColor selectedBgColor:selectedBackGroundColor tag:tag target:target action:action title:title];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    return btn;
}

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
                       title:(NSString *)title{
    UIButton * btn = [self buttonWithFrame:frame normalTitleColor:normalTitleColor selectedTitleColor:selectedTitleColor normalBackGroundColor:normalBackGroundColor selectedBackGroundColor:selectedBackGroundColor tag:tag target:target action:action font:font title:title];
    [btn setBackgroundImage:[UIImage imageFromColor:hightlightBackGroundColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:hightlightTitleColor forState:UIControlStateHighlighted];
    
    return btn;
}

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
                      action:(SEL)action{
    
    CGSize s = [title sizeWithFont:font];
    s.width += horizontalPadding * 2;
    s.height += verticalPadding * 2;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, s.width, s.height)];
    button.backgroundColor = backGroundColor;
    button.tag = tag;
    //button.showsTouchWhenHighlighted = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.contentMode = UIViewContentModeCenter;
    
    [button addTarget: target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)buttonWithNormalImage:(NSString *)normalImage
                     selectedImage:(NSString *)selectedImage
                               tag:(NSInteger)tag
                            target:(id)target
                            action:(SEL)action{
    
    UIImage *image = [UIImage imageNamed:normalImage];
    CGSize s = image.size;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, s.width, s.height)];
    button.tag = tag;
    if (normalImage) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = NO;
    button.contentMode = UIViewContentModeCenter;
    [button addTarget: target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
