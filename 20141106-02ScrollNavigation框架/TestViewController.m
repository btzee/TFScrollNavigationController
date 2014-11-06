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
    
    VC1.title = @"第一个";
    VC2.title = @"第二个";
    VC3.title = @"第三个";
    VC4.title = @"第四个";
    
    NSArray * array = @[VC1,VC2,VC3,VC4];

    TFScrollNavigationController * sc = [[TFScrollNavigationController alloc] initWithControllers:array];
    
    [self addChildViewController:sc];
    
#warning 在这里测试切换要添加到的view : self.view/self.testView
    [self.view addSubview:sc.view];
    
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
