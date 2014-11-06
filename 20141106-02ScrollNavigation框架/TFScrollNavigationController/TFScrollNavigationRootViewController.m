//
//  TFScrollNavigationRootViewController.m
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import "TFScrollNavigationRootViewController.h"

@interface TFScrollNavigationRootViewController ()<UIScrollViewDelegate>

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
        
        
    }
    
    
    return self;
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

    /** 布局内容scrollView */
    [self layoutMyContentScrollView];
    
}


#pragma mark - 内部方法

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




#pragma mark - 其他

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
