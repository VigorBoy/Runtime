//
//  ViewController.m
//  Runtime(动态添加方法)
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

//开发使用场景：如果一个类方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表，可以使用动态给某个类，添加方法解决。
- (void)viewDidLoad {
    [super viewDidLoad];

    Person *p = [[Person alloc] init];
    
    //当前 Person类是没有ture这个方法的  我们需要Runtime 给它动态的添加一个方法
    [p  performSelector:@selector(ture:) withObject:@10];

}


@end
