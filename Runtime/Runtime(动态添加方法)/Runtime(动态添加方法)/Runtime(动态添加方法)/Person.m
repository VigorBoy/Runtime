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


/**
 OC的方法调用,会传递默认两个隐世参数!给IMP(方法实现)
 objc_msgSend(self,_cmd) 一个id self 方法调用者  一个SEL  _cmd 方法编号
 */
void tur(id self, SEL _cmd, NSNumber *meter) {
    
    NSLog(@"跑了%@", meter);
    
}


//如果该类接收到一个没有实现的类方法,就会来到这里
+(BOOL)resolveClassMethod:(SEL)sel
{
    return [super resolveClassMethod:sel];
}

//如果该类接收到一个没有实现的实例方法,就会来到这里
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
