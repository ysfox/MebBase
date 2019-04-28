//
//  UITableView+Extension.m
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

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

/**
 *  去掉table多余的cell的分割线条
 */
-(void)castExtraCellLine{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}


/**
 *  给定指定的标识符注册cell，注意nibName的名字要和identifier名字相同
 *
 *  @param indentifier 唯一标识
 */
-(void)registerCellWithReuseIdentifier:(NSString *)indentifier{
    NSString *sourceFile =[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.nib",indentifier] ofType:nil];
    if (sourceFile) {
        [self registerNib:[UINib nibWithNibName:indentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:indentifier];
    }else{
        [self registerClass:NSClassFromString(indentifier) forCellReuseIdentifier:indentifier];
    }
    
}


/**
 *  用指定的复用标识注册表视图的头部和尾部的视图，注意复用标识符要和类名字相同
 *
 *  @param indentifier 指定的复用表示
 */
-(void)registerHeaderFooterViewWithIdentifier:(NSString *)indentifier{
    NSString *sourceFile =[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.nib",indentifier] ofType:nil];
    if (sourceFile) {
        [self registerNib:[UINib nibWithNibName:indentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:indentifier];
    }else{
        [self registerClass:NSClassFromString(indentifier) forHeaderFooterViewReuseIdentifier:indentifier];
    }
}

@end
