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
    
    NSArray * array = @[[[BTTestAController alloc] init],[[BTTestAController alloc] init],[[BTTestAController alloc] init]];

    TFScrollNavigationController * sc = [[TFScrollNavigationController alloc] initWithControllers:array];
    
    [self addChildViewController:sc];
    
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
