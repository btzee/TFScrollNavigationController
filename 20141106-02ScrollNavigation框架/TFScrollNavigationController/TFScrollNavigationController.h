//
//  TFScrollNavigationController.h
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFScrollNavigationController : UINavigationController


/** 初始化方法 (本框架初始化务必用这个) */
- (instancetype)initWithControllers : (NSArray *) controllers;


/*======================= 以下为内部控件参数设置方法 =======================*/

/** 添加导航栏右侧辅助按钮 (数组形式 , 建议最多添加2个 默认尺寸为正方形 , 长度为 导航栏的高度(默认44)) */
- (BOOL)addTabBarAccessoryButtons:(NSArray *) accessoryButtons;

/** 设置导航栏中的控制器标题字体颜色及尺寸 */
- (void)setTabBarTitleWithNomalColor : (UIColor *)nomalColor AndSelectedColor : (UIColor *)selectedColor AndTitleFont : (UIFont *)font;

/** 设置导航栏背景颜色 */
- (void)setTabBarBackgrondColor : (UIColor *)color;

/** 设置主体内容的背景颜色 (内容左右拉伸到边缘的时候显露出来的背景) */
- (void)setContentBackgrondColor : (UIColor *)color;

 
/*======================= 以上为内部控件参数设置方法 =======================*/



/*======================= 以下为内部控件增删改查方法 =======================*/

/** 根据控制器的title删除对应的控制器 成功返回YES , 失败返回NO */
- (BOOL)removeChildViewControllerWithControllerTitle : (NSString *)title;

/** 根据控制器的title删除对应的控制器组 成功返回YES , 失败返回NO */
- (BOOL)removeChildViewControllersWithControllerTitles : (NSArray *)titlesArray;

/** 根据控制器title数组对控制器的显示位置进行排序 成功返回YES , 失败返回NO */
- (BOOL)sequenceControllersWithControllerTitles : (NSArray *) titlesArray;

/** 添加一个子控制器 到最末 */
- (BOOL)addAnControllerToList : (UIViewController *)viewController;

/** 添加一个子控制器 到列表指定位置 成功返回YES , 失败返回NO */
- (BOOL)addAnController : (UIViewController *)viewController ToListAtIndex : (NSInteger)index;



/*======================= 以上为内部控件增删改查方法 =======================*/



@end
