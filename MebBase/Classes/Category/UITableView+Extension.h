//
//  UITableView+Extension.h
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

@interface UITableView (Extension)

/**
 *  去掉table多余的cell的分割线条
 */
-(void)castExtraCellLine;


/**
 *  给定指定的标识符注册cell，注意nibName的名字要和identifier名字相同
 *
 *  @param indentifier 唯一标识
 */
-(void)registerCellWithReuseIdentifier:(NSString *)indentifier;


/**
 *  用指定的复用标识注册表视图的头部和尾部的视图，注意复用标识符要和类名字相同
 *
 *  @param indentifier 指定的复用表示
 */
-(void)registerHeaderFooterViewWithIdentifier:(NSString *)indentifier;

@end
