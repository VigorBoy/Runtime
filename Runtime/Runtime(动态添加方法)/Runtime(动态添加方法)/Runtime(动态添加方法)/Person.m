//
//  Person.m
//  Runtime(动态添加方法)
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person


void tur(id self, SEL _cmd, NSNumber *meter) {
    
    NSLog(@"跑了%@", meter);
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
    // [NSStringFromSelector(sel) isEqualToString:@"eat"];
    if (sel == NSSelectorFromString(@"ture:")) {
 
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, sel, (IMP)tur, "v@:@");
        
        return YES;
    }
    
    
    return [super resolveInstanceMethod:sel];

}

@end
