//
//  TestViewController.m
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import "TestViewController.h"
#import "TFScrollNavigationController.h"
#import "BTTestAController.h"
#import "UIColor+BTTools.h"
@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
#warning 这是测试用的界面

    BTTestAController * VC1 = [[BTTestAController alloc] init];
    UIViewController * VC2 = [[UIViewController alloc] init];
    BTTestAController * VC3 = [[BTTestAController alloc] init];
    UIViewController * VC4 = [[UIViewController alloc] init];
    BTTestAController * VC5 = [[BTTestAController alloc] init];
    UIViewController * VC6 = [[UIViewController alloc] init];
    BTTestAController * VC7 = [[BTTestAController alloc] init];
    BTTestAController * VC8 = [[BTTestAController alloc] init];
    
    VC1.title = @"我";
    VC2.title = @"第二";
    VC3.title = @"第三个";
    VC4.title = @"第四个啊";
    VC5.title = @"第五个啊哦";
    VC6.title = @"第六个啊哦吖";
    VC7.title = @"第七个";
    VC8.title = @"第八个";
    
    NSArray * controllersArray = @[VC1,VC2,VC3,VC4,VC5,VC6,VC7,VC8];

    for (UIViewController * obj in controllersArray) {
        obj.view.backgroundColor = BTRandomColor;
    }
    
#warning 这是测试用的button
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [button1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

    
    NSArray * buttonsArray = @[button1];
    
    
    TFScrollNavigationController * sc = [[TFScrollNavigationController alloc] initWithControllers:controllersArray];

    [sc addTabBarAccessoryButtons:buttonsArray];
    
    [sc setContentBackgrondColor:[UIColor blueColor]];
    [sc setTabBarBackgrondColor:[UIColor redColor]];
    //[sc setTabBarTitleWithNomalColor:[UIColor blackColor] AndSelectedColor:[UIColor redColor] AndTitleFont:[UIFont systemFontOfSize:17]];
    
    [self addChildViewController:sc];
    
#warning 在这里测试切换要添加到的view : self.view/self.testView
    [self.view addSubview:sc.view];
    
}


- (void)clickButton : (UIButton *)button
{
    NSLog(@"[%s--第%d行]--[点击了测试按钮%@]",__func__,__LINE__,button);
}


@end
