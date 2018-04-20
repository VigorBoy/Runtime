//
//  ViewController.m
//  Runtime(字典转模型KVC实现)
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "ViewController.h"
#import "StatusItem.h"
#import "NSObject+Model.h"


/*
 设计模型：字典转模型的第一步
 模型属性，通常需要跟字典中的key一一对应
 问题：一个一个的生成模型属性，很慢？
 需求：能不能自动根据一个字典，生成对应的属性。
 解决：提供一个分类，专门根据字典生成对应的属性字符串。
 
 字典转模型的方式一：KVC
 KVC字典转模型弊端：必须保证，模型中的属性和字典中的key一一对应。
 如果不一致，就会调用[<Status 0x7fa74b545d60> setValue:forUndefinedKey:] 报key找不到的错。
 分析:模型中的属性和字典的key不一一对应，系统就会调用setValue:forUndefinedKey:报错。
 解决:重写对象的setValue:forUndefinedKey:,把系统的方法覆盖， 就能继续使用KVC，字典转模型了。
 
 字典转模型的方式二：Runtime
 思路：利用运行时，遍历模型中所有属性，根据模型的属性名，去字典中查找key，取出对应的值，给模型的属性赋值。
 步骤：提供一个NSObject分类，专门字典转模型，以后所有模型都可以通过这个分类转。
 
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取文件全路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    
    // 文件全路径
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];

    StatusItem *item = [StatusItem modelWithDict:dict];
    NSLog(@"%@",item.source);


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
