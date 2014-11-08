//
//  TFScrollNavigationController.m
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import "TFScrollNavigationController.h"



#import "TFScrollNavigationRootViewController.h"
#import "TFScrollNavigationBar.h"


@interface TFScrollNavigationController ()


@property (nonatomic , weak) TFScrollNavigationRootViewController * myRootViewController;

@property (nonatomic , weak) TFScrollNavigationBar * myNavigationBar;

@end

@implementation TFScrollNavigationController


#pragma mark - 初始化方法

- (instancetype)initWithControllers : (NSArray *) controllers
{
    /** 初始化主内容模块 */
    TFScrollNavigationRootViewController * rootViewController = [[TFScrollNavigationRootViewController alloc] initWithControllers:controllers];
    
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        self.myRootViewController = rootViewController;
        self.myNavigationBar = rootViewController.myNavigationBar;
        
   
    }
    
    
    
    

    return self;
}


#pragma mark - 系统 : 界面加载

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    
  
}


/** 系统即将显示的时候调用 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /** 隐藏系统自带导航栏 */
    self.navigationBar.hidden = YES ;
    
}


/** 系统自动调用布局方法 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    /** 布局自身的view */
    [self layoutSelfView];
    

}



#pragma mark - 内部 计算Frame方法

/** 布局自身的view */
- (void)layoutSelfView
{
    self.view.frame = self.view.superview.bounds;
}


#pragma mark - 外部调用方法 : 内部控件参数设置方法

/*======================= 以下为内部控件参数设置方法 =======================*/

/** 添加导航栏右侧辅助按钮 (数组形式 , 建议最多添加2个 默认尺寸为正方形 , 长度为 导航栏的高度(默认44)) */
- (BOOL)addTabBarAccessoryButtons:(NSArray *) accessoryButtons
{
    if (!self.myNavigationBar)
    {
        NSLog(@"[%s--第%d行]--[错误:您的自定义导航栏为空!]",__func__,__LINE__);
        return NO;
    }
    
    [self.myNavigationBar addAccessoryButtons:accessoryButtons];
    
    return YES;
}

/** 设置导航栏中的控制器标题字体颜色及尺寸 */
- (void)setTabBarTitleWithNomalColor : (UIColor *)nomalColor AndSelectedColor : (UIColor *)selectedColor AndTitleFont : (UIFont *)font
{
    [self.myNavigationBar setButtonTitleWithNomalColor:nomalColor AndSelectedColor:selectedColor AndTitleFont:font];
    
}

/** 设置导航栏背景颜色 */
- (void)setTabBarBackgrondColor : (UIColor *)color
{
    if (!self.myNavigationBar)
        return;
    
    self.myNavigationBar.backgroundColor = color;

}

/** 设置主体内容的背景颜色 (内容左右拉伸到边缘的时候显露出来的背景) */
- (void)setContentBackgrondColor : (UIColor *)color
{
    if (!self.myRootViewController)
        return;
    
    self.myRootViewController.view.backgroundColor = color;
}


/*======================= 以上为内部控件参数设置方法 =======================*/


#pragma mark - 外部调用方法 : 内部控件增删改查方法

/*======================= 以下为内部控件增删改查方法 =======================*/

/** 根据控制器的title删除对应的控制器 成功返回YES , 失败返回NO */
- (BOOL)removeChildViewControllerWithControllerTitle : (NSString *)title
{

    return NO;
}

/** 根据控制器的title删除对应的控制器组 成功返回YES , 失败返回NO */
- (BOOL)removeChildViewControllersWithControllerTitles : (NSArray *)titlesArray
{

    return NO;
}

/** 根据控制器title数组对控制器的显示位置进行排序 成功返回YES , 失败返回NO */
- (BOOL)sequenceControllersWithControllerTitles : (NSArray *) titlesArray
{

    return NO;
}

/** 添加一个子控制器 到最末 */
- (BOOL)addAnControllerToList : (UIViewController *)viewController
{

    return NO;
}

/** 添加一个子控制器 到列表指定位置 成功返回YES , 失败返回NO */
- (BOOL)addAnController : (UIViewController *)viewController ToListAtIndex : (NSInteger)index
{

    return NO;
}


/*======================= 以上为内部控件增删改查方法 =======================*/




#pragma mark - 其他

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
