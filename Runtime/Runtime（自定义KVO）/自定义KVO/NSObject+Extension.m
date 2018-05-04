//
//  NSObject+Extension.m
//  自定义KVO
//
//  Created by 马文帅 on 2017/10/16.
//  Copyright © 2017年 mawenshuai. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/message.h>

static const char *WSKVO_observer = "WSKVO_observer";
static const char *WSKVO_getter = "WSKVO_getter";
static const char *WSKVO_setter = "WSKVO_setter";

@implementation NSObject (Extension)

- (void)ws_addObserver:(NSObject *_Nonnull)observer forKeyPath:(NSString *_Nonnull)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
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
    class_addMethod(class, setSEL, (IMP)setMethod, types);
    
    //改变isa指针，指向子类
    object_setClass(self, class);
    
    //保存observer
    objc_setAssociatedObject(self, WSKVO_observer, observer, OBJC_ASSOCIATION_ASSIGN);
    
    //保存set、get方法名
    objc_setAssociatedObject(self, WSKVO_setter, setNameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, WSKVO_getter, keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

void setMethod(id self, SEL _cmd, id newValue) {
    //获取get、set方法名
    NSString *setNameStr = objc_getAssociatedObject(self, WSKVO_setter);
    NSString *getNameStr = objc_getAssociatedObject(self, WSKVO_getter);
    
    //保存子类类型
    Class class = [self class];
    
    //isa指向原类
    object_setClass(self, class_getSuperclass(class));
    
    //调用原类get方法，获取oldValue
    id oldValue = objc_msgSend(self, NSSelectorFromString(getNameStr));
    
    //调用原类set方法
    objc_msgSend(self, NSSelectorFromString([setNameStr stringByAppendingString:@":"]), newValue);
    
    //调用observer的observeValueForKeyPath: ofObject: change: context:方法
    id observer = objc_getAssociatedObject(self, WSKVO_observer);
    
    NSMutableDictionary *change = @{}.mutableCopy;
    if (newValue) {
        change[NSKeyValueChangeNewKey] = newValue;
    }
    if (oldValue) {
        change[NSKeyValueChangeOldKey] = oldValue;
    }
    
    objc_msgSend(observer, @selector(observeValueForKeyPath: ofObject: change: context:), getNameStr, self, change, nil);
    
    //isa改回子类类型
    object_setClass(self, class);
}

@end
