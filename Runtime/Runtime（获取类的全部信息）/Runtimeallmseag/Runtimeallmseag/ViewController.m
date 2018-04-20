//
//  ViewController.m
//  Runtimeallmseag
//
//  Created by 上海彭于晏 on 2018/4/20.
//  Copyright © 2018年 上海彭于晏. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Person *person=[[Person alloc]init];
    person.name=@"你好";
    person.age=10;
    
    
    
    [person setValue:@"老师" forKey:@"acction"];
    [person setValue:@"222" forKey:@"userID"];
    
    NSDictionary *dic=[self test1:person];

    // 便利出所有的成员变量和值
    for (NSString *propertyName in dic.allKeys) {
        NSLog(@"nsme:%@, value:%@",propertyName, dic[propertyName]);

    }
    
    
    // 便利出所有的属性
    NSDictionary *ivarResultDic = [self test2:person];
    for (NSString *ivarName in ivarResultDic.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",ivarName, ivarResultDic[ivarName]);
    }
    
    // 便利出所有的方法
    NSDictionary *methodResultDic = [self test3:person];
    for (NSString *methodName in methodResultDic.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodResultDic[methodName]);
    }

    [self test4:person];

}


/**
 获取一个类的全部成员变量
 */
-(NSDictionary *)test1:(id)class
{
    unsigned int count;
    
    NSMutableDictionary *Dic=[NSMutableDictionary dictionary];
    //获取成员变量结构体
    Ivar *ivars=class_copyIvarList([class class], &count);
    
    for (NSInteger i=0; i<count; i++) {
        Ivar ivar=ivars[i];
        
        //根据Ivar指针获取成员变量名称
        const char *name=ivar_getName(ivar);
        
        //C字符串转变OC字符串
        NSString *key=[NSString stringWithUTF8String:name];
        id varValue = [class valueForKey:key];

        if (varValue) {
            Dic[key]=varValue;
        }
        else
        {
            Dic[key] = @"字典的key对应的value不能为nil哦！";
        }
        
    }
    
    free(ivars);
    return Dic;
    
}


/**
 获取一个类的全部属性
 */
-(NSDictionary *)test2:(id)class
{
    unsigned int count;
    
    NSMutableDictionary *resultDict=[NSMutableDictionary dictionary];

    //获取类的所有属性，如果没有属性count就为0
    objc_property_t *properties=class_copyPropertyList([class class], &count);
    
    for (NSUInteger i = 0; i < count; i ++) {
        
        // 获取属性的名称和值
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [class valueForKey:name];
        
        if (propertyValue) {
            resultDict[name] = propertyValue;
        } else {
            resultDict[name] = @"字典的key对应的value不能为nil哦！";
        }
    }
    
    // 这里properties是一个数组指针，我们需要使用free函数来释放内存。
    free(properties);
    
    return resultDict;

}

/**
 获取一个类的全部方法
 */
-(NSDictionary *)test3:(id)class
{
    unsigned int count;
    
    NSMutableDictionary *resultDict=[NSMutableDictionary dictionary];
    
    //获取类的所有方法，如果没有属性count就为0
    Method *methods=class_copyMethodList([class class], &count);
    
    for (NSUInteger i = 0; i < count; i ++) {
        
        // 获取方法名称
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
     
        // 获取方法的参数列表
        int arguments = method_getNumberOfArguments(methods[i]);
        
        resultDict[name] = @(arguments-2);
    }
    
    free(methods);
    
    return resultDict;
    
}

-(void)test4:(id)class{
     unsigned int count;
    
    //获取指向该类遵循的所有协议的指针
   __unsafe_unretained Protocol **protocols =class_copyProtocolList([class class], &count);
    
    
    for (NSUInteger i = 0; i < count; i ++) {
        //获取该类遵循的一个协议指针
        Protocol *protocol=protocols[i];
        
        const char *protocolName = protocol_getName(protocol);
        NSString *name = [NSString stringWithUTF8String:protocolName];
        
        NSLog(@"%@",name);
        
    }
    
    free(protocols);
}



@end
