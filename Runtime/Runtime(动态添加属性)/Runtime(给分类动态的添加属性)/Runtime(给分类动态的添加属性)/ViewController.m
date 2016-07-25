//
//  ViewController.m
//  Runtime(给分类动态的添加属性)
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Property.h"

@interface ViewController ()

@end

@implementation ViewController

// 原理：给一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类存空间。


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *object=[[NSObject alloc]init];
    
    object.name=@"aa";
    
    NSLog(@"%@",object.name);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
