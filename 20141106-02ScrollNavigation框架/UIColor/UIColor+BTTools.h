//
//  UIColor+BTTools.h
//  20141007-01新浪微博项目
//
//  Created by btz-mac on 14-10-7.
//  Copyright (c) 2014年 btz. All rights reserved.
//

#import <UIKit/UIKit.h>


#define BTColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define BTColor(r,g,b) BTColorAlpha((r),(g),(b),1.0)
#define BTRandomColor [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:(arc4random_uniform(256))/255.0 blue:(arc4random_uniform(256))/255.0 alpha:1.0]


@interface UIColor (BTTools)



@end
