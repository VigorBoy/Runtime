//
//  ViewController.m
//  Runtime(交换方法)
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



/*
 Runtime(交换方法 网上也有网友称呼这个方法为黑魔法 Method Swizzle):只要想修改系统的方法实现
 
 需求:
 
 比如说有一个项目,已经开发了2年,忽然项目负责人添加一个功能,每次UIImage加载图片,告诉我是否加载成功
 
 // 给系统的imageNamed添加功能,只能使用runtime(交互方法)
 // 1.给系统的方法添加分类
 // 2.自己实现一个带有扩展功能的方法
 // 3.交互方法,只需要交互一次,
 
 // 1.自定义UIImage
 
 // 2.UIImage添加分类
 
 弊端:
 1.每次使用,都需要导入
 2.项目大了,没办法实现
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // imageNamed => xmg_imageNamed 交互这两个方法实现
    UIImage *image = [UIImage imageNamed:@"Snip20160725_1.png"];


}


@end
