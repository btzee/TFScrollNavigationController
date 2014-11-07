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

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BTTestAController * VC1 = [[BTTestAController alloc] init];
    BTTestAController * VC2 = [[BTTestAController alloc] init];
    BTTestAController * VC3 = [[BTTestAController alloc] init];
    BTTestAController * VC4 = [[BTTestAController alloc] init];
    BTTestAController * VC5 = [[BTTestAController alloc] init];
    BTTestAController * VC6 = [[BTTestAController alloc] init];
    BTTestAController * VC7 = [[BTTestAController alloc] init];
    BTTestAController * VC8 = [[BTTestAController alloc] init];
    
    VC1.title = @"一";
    VC2.title = @"第二";
    VC3.title = @"第三个";
    VC4.title = @"第四个啊";
    VC5.title = @"第五个啊哦";
    VC6.title = @"第六个啊哦吖";
    VC7.title = @"第七个";
    VC8.title = @"第八个";
    
    NSArray * array = @[VC1,VC2,VC3,VC4,VC5,VC6,VC7,VC8];

    TFScrollNavigationController * sc = [[TFScrollNavigationController alloc] initWithControllers:array];
    
#warning 这是测试用的button
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [sc addTabBarAccessoryButtons:@[button1,button2]];
    [sc setContentBackgrondColor:[UIColor blueColor]];
    [sc setTabBarBackgrondColor:[UIColor yellowColor]];
    [sc setTabBarTitleWithNomalColor:[UIColor blackColor] AndSelectedColor:[UIColor redColor] AndTitleFont:[UIFont systemFontOfSize:30]];
    
    
    [self addChildViewController:sc];
    
#warning 在这里测试切换要添加到的view : self.view/self.testView
    [self.testView addSubview:sc.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
