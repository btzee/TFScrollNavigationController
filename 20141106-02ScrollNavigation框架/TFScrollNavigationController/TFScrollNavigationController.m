//
//  TFScrollNavigationController.m
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import "TFScrollNavigationController.h"

#import "TFScrollNavigationRootViewController.h"


@interface TFScrollNavigationController ()


@property (nonatomic , weak) TFScrollNavigationRootViewController * myRootViewController;

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

    
    
    }
    
    
    
    

    return self;
}


#pragma mark - 系统 : 界面加载

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"[%s--第%d行]--[]",__func__,__LINE__);
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


#pragma mark - 其他

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
