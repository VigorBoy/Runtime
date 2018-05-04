//
//  Person.m
//  Runtime(消息转发机制)
//
//  Created by 上海彭于晏 on 2018/5/4.
//  Copyright © 2018年 上海彭于晏. All rights reserved.
//

#import "Person.h"

@implementation Person
// 第一步：我们不动态添加方法，返回NO，进入第二步；
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}

// 第二部：我们不指定备选对象响应aSelector，进入第三步；
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}


// 第三步：返回方法选择器，然后进入第四部；
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// 第四部：这步我们修改调用方法
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation setSelector:@selector(dance)];
    // 这还要指定是哪个对象的方法
    [anInvocation invokeWithTarget:self];

}

// 若forwardInvocation没有实现，则会调用此方法
- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"消息无法处理：%@", NSStringFromSelector(aSelector));
}

- (void)dance
{
    NSLog(@"跳舞！！！come on！");
}


@end
