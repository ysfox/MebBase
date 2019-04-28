//
//  UITextField+Extension.m
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

#import "UITextField+Extension.h"
#import <objc/runtime.h>

static const void *leftPaddingKey= &leftPaddingKey;
static const void *rightPaddingKey= &rightPaddingKey;
static const void *placeHolderColorKey = &placeHolderColorKey;

@implementation UITextField (Extension)

-(CGFloat)leftPadding{
    return [objc_getAssociatedObject(self, leftPaddingKey) floatValue];
}

-(void)setLeftPadding:(CGFloat)leftPadding{
    CGRect frame = self.frame;
    frame.size.width =leftPadding;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    objc_setAssociatedObject(self,leftPaddingKey,[NSNumber numberWithFloat:leftPadding], OBJC_ASSOCIATION_ASSIGN);
}

-(CGFloat)rightPadding{
    return [objc_getAssociatedObject(self, rightPaddingKey) floatValue];
}

-(void)setRightPadding:(CGFloat)rightPadding{
    CGRect frame = self.frame;
    frame.size.width =rightPadding;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = leftview;
    objc_setAssociatedObject(self,rightPaddingKey,[NSNumber numberWithFloat:rightPadding], OBJC_ASSOCIATION_ASSIGN);
}

-(UIColor *)placeHolderColor{
    return objc_getAssociatedObject(self, placeHolderColorKey);
}

-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    objc_setAssociatedObject(self,placeHolderColorKey, placeHolderColor, OBJC_ASSOCIATION_RETAIN);
}


/**
 *  快速创建文本输入框
 *
 *  @param frame          尺寸
 *  @param placeholder    提示字体
 *  @param isPassWord     是否是密码
 *  @param leftImageView  左边图片
 *  @param rightImageView 右边图片
 *  @param font           字体
 *
 *  @return 返回输入框
 */
+(UITextField*)textFieldWithFrame:(CGRect)frame
                      placeholder:(NSString*)placeholder
                       isPassWord:(BOOL)isPassWord
                    leftImageView:(UIImageView*)leftImageView
                   rightImageView:(UIImageView*)rightImageView
                             font:(float)font{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    textField.placeholder=placeholder;
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=isPassWord;
    //textField.borderStyle=UITextBorderStyleLine;
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    textField.autocapitalizationType=NO;
    textField.clearButtonMode=YES;
    textField.leftView=leftImageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.rightView=rightImageView;
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    textField.font=[UIFont systemFontOfSize:font];
    textField.textColor=[UIColor blackColor];
    return textField;
}

@end
