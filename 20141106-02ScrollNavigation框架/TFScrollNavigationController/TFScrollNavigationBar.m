//
//  TFScrollNavigationBar.m
//  20141106-02ScrollNavigation框架
//
//  Created by btz-mac on 14-11-6.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//
#import "UIColor+BTTools.h"

#import "TFScrollNavigationBar.h"


#define Default_Selected_Color [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]

@interface TFScrollNavigationBar ()


/** 标题scrollView (重写属性的目的 : 外界只读 , 内部可读可写) */
@property (nonatomic , weak , readwrite) UIScrollView * titleScrollView;

/** 右侧辅助按钮数组 (重写属性的目的 : 外界只读 , 内部可读可写) */
@property (nonatomic , strong , readwrite) NSArray * accessoryButtons;

/** 标题按钮数组 */
@property (nonatomic , strong) NSMutableArray * titleButtons;

/** 底部滑动下划线 */
@property (nonatomic , weak) CALayer * underLine;

/** 当前选中的按钮 */
@property (nonatomic , weak) UIButton * selectedButton;

@end

@implementation TFScrollNavigationBar




#pragma mark - 初始化方法

/** 根据传进来的控制器数组进行初始化 , 实际目的只是为了获取控制器的标题 */
- (instancetype)initWithControllers : (NSArray *) controllers
{
    self = [super init];
    if (self)
    {
        /** 添加子控制器的标题 */
        [self addTitlesFromChildViewControllers: controllers];
        
        /** 默认初始选中按钮为第一个 */
        if (self.titleButtons.count > 0)
            self.selectedButton = [self.titleButtons firstObject];
        
    }

    return self;
}


#pragma mark - 参数懒加载

/** 标题scrollView */
- (UIScrollView *)titleScrollView
{
    if(_titleScrollView == nil)
    {
        UIScrollView * temp = [[UIScrollView alloc] init];
        
        /** 隐藏contentScrollView的垂直与水平的滚动条 */
        temp.showsVerticalScrollIndicator = NO;
        temp.showsHorizontalScrollIndicator = NO;

        
        [self addSubview:temp];
        _titleScrollView = temp ;
    }
    
    return _titleScrollView;
}

/** 标题按钮数组 */
- (NSMutableArray *)titleButtons
{
    if(_titleButtons == nil)
    {
        NSMutableArray * temp = [NSMutableArray array];
        
        _titleButtons = temp ;
    }
    
    return _titleButtons;
}


/** 底部滑动下划线 */
- (CALayer *)underLine
{
    if(_underLine == nil)
    {
        CALayer * temp = [[CALayer alloc] init];
        
        /** 设置线段端点样式 */
        temp.cornerRadius = 3.0;
        
        temp.backgroundColor = Default_Selected_Color.CGColor;
        
        [self.titleScrollView.layer addSublayer:temp];
        _underLine = temp ;
    }
    
    return _underLine;
}


#pragma mark - 参数重写set,get方法

/** 重写setSelectedButton set方法 */
- (void)setSelectedButton:(UIButton *)selectedButton
{
    _selectedButton = selectedButton;
    
    _selectedButton.enabled = NO;
    _selectedButton.userInteractionEnabled = NO;
    
    
    /** 滚动选中的按钮到scrollView中心位置 */
    [self scrollSelectedButtonToCenter];
    
}

/** 重写setTitleNomalColor set方法 */
- (void)setTitleNomalColor:(UIColor *)titleNomalColor
{
    _titleNomalColor = titleNomalColor;
    
    for (UIButton * obj in self.titleButtons) {
        
        [obj setTitleColor:titleNomalColor forState:UIControlStateNormal];
    }

}

/** 重写setTitleSelectedColor set方法 */
- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    _titleSelectedColor = titleSelectedColor;
    
    for (UIButton * obj in self.titleButtons) {
        
        [obj setTitleColor:titleSelectedColor forState:UIControlStateDisabled];
        [obj setTitleColor:titleSelectedColor forState:UIControlStateSelected];
    }
    
    self.underLine.backgroundColor = titleSelectedColor.CGColor;
    
}



#pragma mark - 按钮点击事件

/** 设置按钮点击事件 */
- (void)clickButton : (UIButton *)button
{
    if (self.selectedButton == button)
        return;

    self.selectedButton.enabled = YES;
    self.selectedButton.userInteractionEnabled = YES;
    
    self.selectedButton = button;
    
    [self layoutUnderLine];
    
    
}





#pragma mark - 内部方法

/** 添加子控制器的标题 */
- (void)addTitlesFromChildViewControllers : (NSArray *)controllers
{
    
    for (UIViewController * obj in controllers) {
        if (obj.title.length < 1)
        {
            NSLog(@"[%s--第%d行]--[错误:没有设置控制器的标题!]",__func__,__LINE__);
            return;
        }
        
        /** 根据标题添加按钮 */
        [self addButtonWithTitle:obj.title];
        
    }

}


/** 添加标题scrollView内的按钮 */
- (void)addButtonWithTitle : (NSString *)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    /** 设置按钮标题 */
    [button setTitle:title forState:UIControlStateNormal];
    
    /** 设置按钮默认选中颜色 */
    [button setTitleColor:Default_Selected_Color forState:UIControlStateDisabled];
    [button setTitleColor:Default_Selected_Color forState:UIControlStateSelected];

    
    /** 设置按钮点击事件 */
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 将按钮添加到scrollView里面 */
    [self.titleScrollView addSubview:button];
    [self.titleButtons addObject:button];
    
}


/** 添加右侧辅助按钮 (数组形式 , 建议最多添加2个 ) */
- (void)addAccessoryButtons:(NSArray *) accessoryButtons
{
 
    if (accessoryButtons.count<1)
    {
        NSLog(@"[%s--第%d行]--[警告:按钮数组为空,请确认是否传入空数组!]",__func__,__LINE__);
        self.accessoryButtons = nil;
        return;
    }
    
    self.accessoryButtons = nil;
    NSMutableArray * array = [NSMutableArray array];
    
    for (UIButton * obj in accessoryButtons) {
        
        if (![obj isKindOfClass:[UIButton class]])
        {
            NSLog(@"[%s--第%d行]--[错误:请添加UIButton类型的按钮!如果需要自定义,可修改此处的代码!]",__func__,__LINE__);
            return;
        }
        
        [array addObject:obj];
        [self addSubview:obj];
        
    }
    
    self.accessoryButtons = array;
    
}


#pragma mark - 内部 Frame 计算方法

/** 系统自动调用布局方法 */
- (void)layoutSubviews
{
    [super layoutSubviews];

    /** 布局辅助按钮 */
    [self layoutAccessoryButtons];
    
    /** 布局标题scrollView */
    [self layoutTitleScrollView];
    
    /** 布局下划线layer */
    [self layoutUnderLine];
}


/** 布局辅助按钮 */
- (void)layoutAccessoryButtons
{
    if (self.accessoryButtons.count < 1)
        return;
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = height;
    CGFloat x = self.bounds.size.width - width;
    CGFloat y = 0;
    
    for (UIButton * obj in self.accessoryButtons) {
        
        obj.frame = CGRectMake(x, y, width, height);
        
        x = x - width;
    }
    

}

/** 布局标题scrollView */
- (void)layoutTitleScrollView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = self.bounds.size.height;
    
    /** 标题scrollView的宽度 根据辅助按钮的位置进行判断 */
    CGFloat width = 0;
    
    if (self.accessoryButtons.count > 0)
    {
        UIButton * button = [self.accessoryButtons lastObject];
        
        width = CGRectGetMinX(button.frame);
    }
    else
    {
        width = self.bounds.size.width;
    }
    
    self.titleScrollView.frame = CGRectMake(x, y, width, height);
    
    
    /** 设置标题ScrollView的内容Size */
    CGFloat sizeHeight = height;
    CGFloat sizeWidth = [self layoutTitleButtons];
    
    self.titleScrollView.contentSize = CGSizeMake(sizeWidth, sizeHeight);

}

/** 布局标题ScrollView内部的按钮 , 并返回最后一个按钮的最大X值*/
- (CGFloat)layoutTitleButtons
{
    for( NSInteger i = 0 ; i < self.titleButtons.count ; i++)
    {
        
        UIButton * tempButton = self.titleButtons[i];
        
        /** 计算第一个按钮的frame */
        if (i == 0)
        {
            CGFloat x = 0;
            CGFloat y = 0;
            CGSize size = [self sizeWithButton:tempButton];
            
            tempButton.frame = CGRectMake(x, y, size.width, size.height);
            continue;
        }
        
        /** 根据前一个按钮计算后面按钮的位置 */
        UIButton * lastButton = self.titleButtons[i-1];
        
        CGFloat x = CGRectGetMaxX(lastButton.frame);
        CGFloat y = lastButton.frame.origin.y;
        CGSize size = [self sizeWithButton:tempButton];
        
        tempButton.frame = CGRectMake(x, y, size.width, size.height);
        
        
    }
    
    /** 获取最后一个按钮 */
    UIButton * button = [self.titleButtons lastObject];
    
    return CGRectGetMaxX(button.frame);
}

/** 布局下划线layer */
- (void)layoutUnderLine
{

    self.underLine.frame = CGRectMake(self.selectedButton.frame.origin.x, self.bounds.size.height - 2, self.selectedButton.frame.size.width, 2);

}


#pragma mark - 内部 自定义 计算方法

/** 根据按钮标题字体属性计算每个button的大小 */
- (CGSize)sizeWithButton : (UIButton *)button
{
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    
    UIFont * font = button.titleLabel.font;
    
    /** 设置按钮标题的字体属性 */
    if (self.titleFont)
    {
        font = self.titleFont;
        [button.titleLabel setFont:font];
    }

    attributes[NSFontAttributeName] = button.titleLabel.font;

    /** 计算按钮标题的size */
    CGRect rect = [button.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.titleScrollView.bounds.size.height ) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    CGSize size = CGSizeMake(rect.size.width + 4, self.titleScrollView.bounds.size.height);
    /** 设置按钮内部label的大小 */
    button.titleLabel.frame = CGRectMake(0, 0, size.width, size.height);
    /** 设置文字居中 */
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    return size;
}


/** 滚动选中的按钮到scrollView中心位置 */
- (void)scrollSelectedButtonToCenter
{

   
    CGFloat scrollViewCenterX = self.titleScrollView.center.x;
    CGFloat selectedButtonCenterX = self.selectedButton.center.x;
    
    CGFloat scrollOffset = selectedButtonCenterX - scrollViewCenterX ;
    
    /** 如果滚动会超过起始位置 , 则偏移置0 */
    if (scrollOffset < 0 )
        scrollOffset = 0;
    
    /** 如果滚动会超过最末位置 , 则偏移置为最末 */
    if (scrollOffset > (self.titleScrollView.contentSize.width - self.titleScrollView.bounds.size.width))
        scrollOffset = self.titleScrollView.contentSize.width - self.titleScrollView.bounds.size.width;
    
    /** 以动画形式滚动 */
    [UIView animateWithDuration:0.5 animations:^{
   
        self.titleScrollView.contentOffset = CGPointMake(scrollOffset, self.titleScrollView.contentOffset.y);
        
    } completion:^(BOOL finished) {
        
       // NSLog(@"偏移:%@--按钮中心:%@--导航栏中心%@",NSStringFromCGPoint(self.titleScrollView.contentOffset),NSStringFromCGPoint(self.selectedButton.center),NSStringFromCGPoint(self.titleScrollView.center));
        
    }];
    
    
    
    
}


@end
