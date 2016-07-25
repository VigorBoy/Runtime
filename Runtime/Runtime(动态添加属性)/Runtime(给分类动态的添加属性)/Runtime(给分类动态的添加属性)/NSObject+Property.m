//
//  NSObject+Property.m
//  Runtime(给分类动态的添加属性)
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/message.h>


@implementation NSObject (Property)



-(void)setName:(NSString *)name
{
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
//    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}

@end
