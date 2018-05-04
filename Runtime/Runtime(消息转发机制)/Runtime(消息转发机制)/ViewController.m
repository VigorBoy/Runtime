//
//  ViewController.m
//  Runtime(消息转发机制)
//
//  Created by 上海彭于晏 on 2018/5/4.
//  Copyright © 2018年 上海彭于晏. All rights reserved.
//

#import "ViewController.h"
#import "Bird.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Bird *bird=[[Bird alloc]init];
    
    //Bird 类没有sing方法实现 通过消息转发 让people类来完成sing方法实现
    [bird  performSelector:@selector(sing) withObject:nil];

    Person *son=[[Person alloc]init];
    //Person 类没有sing方法实现 通过消息转发 实现dance方法
    [son  performSelector:@selector(sing) withObject:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
