//
//  NSObject+WSKVO.m
//  自定义KVO
//
//  Created by 马文帅 on 2017/10/26.
//  Copyright © 2017年 mawenshuai. All rights reserved.
//

#import "NSObject+WSKVO.h"
#import <objc/message.h>

static const char *WSKVO_getter_key = "WSKVO_getter_key";
static const char *WSKVO_setter_key = "WSKVO_setter_key";
static const char *WSKVO_block_key = "WSKVO_block_key";

@implementation NSObject (WSKVO)


- (void)ws_observerkeyPath:(NSString *_Nonnull)keyPath options:(NSKeyValueObservingOptions)options block:(WSKVOBlock _Nonnull )block {
    //创建、注册子类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [NSString stringWithFormat:@"WSKVONotifying_%@", oldClassName];
    
    Class class = objc_getClass(newClassName.UTF8String);
    if (!class) {
        class = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
        objc_registerClassPair(class);
    }
    
    //set方法首字母大写
    NSString *keyPathChange = [[[keyPath substringToIndex:1] uppercaseString] stringByAppendingString:[keyPath substringFromIndex:1]];
    NSString *setNameStr = [NSString stringWithFormat:@"set%@", keyPathChange];
    SEL setSEL = NSSelectorFromString([setNameStr stringByAppendingString:@":"]);
    
    //添加set方法
    Method getMethod = class_getInstanceMethod([self class], @selector(keyPath));
    const char *types = method_getTypeEncoding(getMethod);
    class_addMethod(class, setSEL, (IMP)setterMethod, types);
    
    //改变isa指针，指向子类
    object_setClass(self, class);
    
    //保存set、get方法名
    objc_setAssociatedObject(self, WSKVO_setter_key, setNameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, WSKVO_getter_key, keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //保存block
    objc_setAssociatedObject(self, WSKVO_block_key, block, OBJC_ASSOCIATION_COPY);
}

void setterMethod(id self, SEL _cmd, id newValue) {
    //获取get、set方法名
    NSString *setNameStr = objc_getAssociatedObject(self, WSKVO_setter_key);
    NSString *getNameStr = objc_getAssociatedObject(self, WSKVO_getter_key);
    
    //保存子类类型
    Class class = [self class];
    
    //isa指向原类
    object_setClass(self, class_getSuperclass(class));
    
    //调用原类get方法，获取oldValue
    id oldValue = objc_msgSend(self, NSSelectorFromString(getNameStr));
    
    //调用原类set方法
    objc_msgSend(self, NSSelectorFromString([setNameStr stringByAppendingString:@":"]), newValue);
    
    NSMutableDictionary *change = @{}.mutableCopy;
    if (newValue) {
        change[NSKeyValueChangeNewKey] = newValue;
    }
    if (oldValue) {
        change[NSKeyValueChangeOldKey] = oldValue;
    }
    
    //取出block
    WSKVOBlock block = objc_getAssociatedObject(self, WSKVO_block_key);
    if (block) {
        block(change);
    }
    
    //isa改回子类类型
    object_setClass(self, class);
}

@end
