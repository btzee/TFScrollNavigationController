//
//  TFScrollNavigationBar.h
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFScrollNavigationBar;

@protocol TFScrollNavigationBar <NSObject>

@optional

/** 选中一个按钮后告诉代理 */
- (void)scrollNavigationBar:(TFScrollNavigationBar *)scrollNavigationBar DidSelectedButton : (UIButton *)button;

@end


@interface TFScrollNavigationBar : UIView

/** 代理 */
@property (nonatomic , weak) id<TFScrollNavigationBar> delegate;

/** 标题scrollView */
@property (nonatomic , weak , readonly) UIScrollView * titleScrollView;

/** 右侧辅助按钮数组 */
@property (nonatomic , strong , readonly) NSArray * accessoryButtons;

/** 标题显示字体的大小 (根据字体计算标题长度 , 该参数为nil时默认跟随系统)*/
@property (nonatomic , strong) UIFont * titleFont;

/** 标题显示文字及下划线的颜色 */
@property (nonatomic , strong) UIColor * titleSelectedColor;

/** 标题显示文字常规颜色 */
@property (nonatomic , strong) UIColor * titleNomalColor;

/** 当前选中的按钮 */
@property (nonatomic , weak , readonly) UIButton * selectedButton;

/** 标题按钮数组 */
@property (nonatomic , strong , readonly) NSMutableArray * titleButtons;



/** 根据传进来的控制器数组进行初始化 (本方法只为了拿到控制器的标题,不强引用控制器) */
- (instancetype)initWithControllers : (NSArray *) controllers;

/** 添加右侧辅助按钮 (数组形式 , 建议最多添加2个 ) */
- (void)addAccessoryButtons:(NSArray *) accessoryButtons;

/** 设置按钮点击事件 (外部调用该方法只为了选中传入的按钮) */
- (void)clickButton : (UIButton *)button;

/** 根据数组item的位置滚动下划线 (非特殊情况,不建议调用该方法) */
- (void)scrollUnderLineFromLastIndex : (NSInteger)lastIndex ToNextIndex : (NSInteger)nextIndex;

/** 设置导航栏中的控制器标题按钮字体颜色及尺寸 */
- (void)setButtonTitleWithNomalColor : (UIColor *)nomalColor AndSelectedColor : (UIColor *)selectedColor AndTitleFont : (UIFont *)font;


@end
