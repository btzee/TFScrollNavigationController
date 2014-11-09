TFScrollNavigationController
============================

TFScrollNavigationController滚动导航控制器框架


/*======================= TFScrollNavigationController 框架 使用说明 =======================

使用方法:

        1. 导入头文件 : #import "TFScrollNavigationController.h"
 
        2. 先将要添加的其他控制器组 初始化完成 , 并添加进数组. 例: array = @[ [[UIViewController alloc] init] , ... ];
 
        3. 根据创建的控制器数组初始化本滚动导航控制器 . 例: TFScrollNavigationController * svc = [[TFScrollNavigationController alloc] initWithControllers:array];
 
        4. 或者也可以继承自本控制器 , 重写 init方法 , 里面用 self = [[TFScrollNavigationController alloc] initWithControllers:array] 进行初始化.
 
        5. 再将创建的滚动导航控制器添加到父级控制器上.
 
        6. 可以添加导航栏右侧的辅助按钮 , 建议添加最多不要超过2个, 太多了会影响用户体验. 例: [self addTabBarAccessoryButtons : buttonsArray];
 
        7. 可以设置相关属性 :
 
            设置导航栏中的控制器标题字体颜色及尺寸 :
            - (void)setTabBarTitleWithNomalColor : (UIColor *)nomalColor AndSelectedColor : (UIColor *)selectedColor AndTitleFont : (UIFont *)font;

            设置导航栏背景颜色 :
            - (void)setTabBarBackgrondColor : (UIColor *)color;

            设置主体内容的背景颜色 (内容左右拉伸到边缘的时候显露出来的背景) :
            - (void)setContentBackgrondColor : (UIColor *)color;
 
 
        8. 可以对添加进来的控制器进行增删改查 , 详细方法见下方方法注释.
 
        9. 通哥友情提示 : 本框架已适配任意view , 如 : 可以将 本控制器的view添加进任意界面的内部view上.
 


 
 ======================= TFScrollNavigationController 框架 使用说明 =======================*/


详细介绍可见 "TFScrollNavigationController.h" 头部说明.


