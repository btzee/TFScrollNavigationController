//
//  TFScrollNavigationRootViewController.m
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import "TFScrollNavigationRootViewController.h"


static NSString * const selectedViewControllerName_KeyPath = @"selectedButton.titleLabel.text";


@interface TFScrollNavigationRootViewController ()<UIScrollViewDelegate>

/** 内容scrollView (重写属性的目的 : 外界只读 , 内部可读可写) */
@property (nonatomic , weak , readwrite) UIScrollView * contentScrollView;

/** 自定义导航栏 (重写属性的目的 : 外界只读 , 内部可读可写) */
@property (nonatomic , weak , readwrite) TFScrollNavigationBar * myNavigationBar;



@end

@implementation TFScrollNavigationRootViewController


#pragma mark - 初始化方法

/** 根据传进来的控制器数组进行初始化 */
- (instancetype)initWithControllers : (NSArray *) controllers
{
    self = [super init];
    
    if (self)
    {
        /** 将控制器数组添加进子控制器组里 */
        [self addChildViewControllers:controllers];
        
        /** 添加自定义导航栏 */
        TFScrollNavigationBar * navigationBar = [[TFScrollNavigationBar alloc] initWithControllers:controllers];
        
        
        /** KVO 监听选中的按钮的变化 */
        [navigationBar addObserver:self forKeyPath:selectedViewControllerName_KeyPath options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)  context:nil];
        
        
        self.myNavigationBar = navigationBar;
        [self.view addSubview:navigationBar];

    }
    
    
    return self;
}


#pragma mark - KVO 监听方法


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /** 判断哪一个监听键值 */
    if ([keyPath isEqualToString:selectedViewControllerName_KeyPath])
    {
        NSString * title = change[@"new"];
        
        NSLog(@"获取的按钮:%@",title);
        
        UIViewController * selectedViewController = [self viewControllerWithTitle:title fromControllers:self.childViewControllers];
        
        /** 滚动界面到指定的控制器 */
            [self scrollToViewController:selectedViewController];
    
    }
    
}



#pragma mark - 参数懒加载

/** 懒加载内容scrollView */
- (UIScrollView *)contentScrollView
{
    if(_contentScrollView == nil)
    {
        UIScrollView * tempScrollView = [[UIScrollView alloc] init];
        
        /** 设置内容分页模式 */
        tempScrollView.pagingEnabled = YES;
        
        /** 隐藏contentScrollView的垂直与水平的滚动条 */
        tempScrollView.showsVerticalScrollIndicator = NO;
        tempScrollView.showsHorizontalScrollIndicator = NO;
        
        /** 设置代理 */
        tempScrollView.delegate = self;

        
        [self.view addSubview:tempScrollView];
        _contentScrollView = tempScrollView ;
    }
    
    return _contentScrollView;
}


#pragma mark - 系统 : 界面加载方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"[%s--第%d行]--[]",__func__,__LINE__);
}


/** 系统即将显示的时候调用 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /** 隐藏系统自带导航栏 */
    self.navigationController.navigationBar.hidden = YES ;
    
}


/** 系统自动调用布局方法 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    /** 布局自身的view */
    [self layoutSelfView];
    
    /** 布局自定义导航栏 */
    [self layoutMyNavigationBar];

    /** 布局内容scrollView */
    [self layoutMyContentScrollView];
    
}


#pragma mark - 内部方法

/** 在控制器数组中根据标题查找对应的控制器并返回 , 如果没有找到返回空 */
- (UIViewController *)viewControllerWithTitle : (NSString *)title fromControllers : (NSArray *) controllers
{
    for (UIViewController * obj in controllers) {
        
        if([obj.title isEqualToString:title])
            return obj;
        
    }
    
    
    return nil;
}


/** 滚动界面到指定的控制器 */
- (void)scrollToViewController : (UIViewController *) viewController
{
    
    CGFloat scrollOffset = viewController.view.frame.origin.x;
    
    /** 以动画形式滚动 */
    [UIView animateWithDuration:0.5 animations:^{
        
        self.contentScrollView.contentOffset = CGPointMake(scrollOffset, self.contentScrollView.contentOffset.y);
        
    } completion:^(BOOL finished) {

        
    }];

    

}



#pragma mark - 内部 初始化方法

/** 添加子控制器 */
- (void)addChildViewControllers:(NSArray *)childControllers
{

    for (UIViewController * obj in childControllers) {
        
        if (![obj isKindOfClass:[UIViewController class]])
        {
            NSLog(@"[%s--第%d行]--[错误:子控制器添加错误!]",__func__,__LINE__);
            return;
        }
        
        [self addChildViewController:obj];
        
        /** 将控制器的view添加到内容scrollView上 */
        [self.contentScrollView addSubview:obj.view];
    }

}

#pragma mark - 内部 计算Frame方法


/** 布局自身的view */
- (void)layoutSelfView
{
    self.view.frame = self.view.superview.bounds;
}

/** 布局自定义导航栏 */
- (void)layoutMyNavigationBar
{
    self.myNavigationBar.frame = self.navigationController.navigationBar.frame;
}

/** 布局内容scrollView */
- (void)layoutMyContentScrollView
{
    /** 清空scrollView的偏移 */
    self.contentScrollView.contentInset = UIEdgeInsetsZero;
    self.contentScrollView.contentOffset = CGPointZero;
    
    //NSLog(@"内容偏移:%@,内边距:%@",NSStringFromCGPoint(self.contentScrollView.contentOffset),NSStringFromUIEdgeInsets(self.contentScrollView.contentInset));
    
    /** 布局contentScrollView的frame */
    self.contentScrollView.frame = self.view.bounds;
    
    /** 布局contentScrollView的contentSize */
    CGSize contentSize = CGSizeMake(self.contentScrollView.bounds.size.width * self.contentScrollView.subviews.count, self.contentScrollView.bounds.size.height);
    
    self.contentScrollView.contentSize = contentSize;
    
    
    /** 布局contentScrollView内部的子视图 */
    for( NSInteger i = 0 ; i < self.contentScrollView.subviews.count ; i++)
    {
        UIView * tempView = self.contentScrollView.subviews[i];
        
        tempView.frame = CGRectMake(self.contentScrollView.bounds.size.width * i, 0 , self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);
        
        if ([tempView isKindOfClass:[UIScrollView class]])
        {
            /** 如果是scrollView或其子类 , 则重新计算下内容偏移 */
            ((UIScrollView *)tempView).contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame), 0, 0, 0);
            ((UIScrollView *)tempView).contentOffset = CGPointMake(0, -CGRectGetMaxY(self.navigationController.navigationBar.frame));
        }
        
    }
    
    
}


#pragma mark - scrollView 的代理 事件方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //if (scrollView.contentOffset.y)

}



#pragma mark - 其他

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
