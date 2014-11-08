//
//  TFScrollNavigationRootViewController.h
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFScrollNavigationBar.h"

@interface TFScrollNavigationRootViewController : UIViewController

/** 内容scrollView */
@property (nonatomic , weak , readonly) UIScrollView * contentScrollView;

/** 自定义导航栏 */
@property (nonatomic , weak , readonly) TFScrollNavigationBar * myNavigationBar;


/** 根据传进来的控制器数组进行初始化 */
- (instancetype)initWithControllers : (NSArray *) controllers;



@end
