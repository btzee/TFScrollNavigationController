//
//  TFScrollNavigationBar.h
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFScrollNavigationBar : UIView

/** 标题scrollView */
@property (nonatomic , weak , readonly) UIScrollView * titleScrollView;

/** 右侧辅助按钮数组 */
@property (nonatomic , strong , readonly) NSArray * accessoryButtons;

/** 标题显示字体attributes (根据字体计算标题长度 , 该参数为nil时默认跟随系统)*/
@property (nonatomic , strong) NSMutableDictionary * titleAttributes;


/** 根据传进来的控制器数组进行初始化 */
- (instancetype)initWithControllers : (NSArray *) controllers;

/** 添加右侧辅助按钮 (数组形式 , 建议最多添加2个 ) */
- (void)addAccessoryButtons:(NSArray *) accessoryButtons;



@end
