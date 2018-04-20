//
//  Person.h
//  Runtimeallmseag
//
//  Created by 上海彭于晏 on 2018/4/20.
//  Copyright © 2018年 上海彭于晏. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol Persondelegate <NSObject>

-(void)PersonName;
@end


@interface Person : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) int age;
@property (nonatomic,weak) id<Persondelegate> XH_delegate;

-(void)eat:(NSString *)name;

-(void)stor:(NSString *)ID age:(int)age;

-(void)disms;

@end
