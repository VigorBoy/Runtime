//
//  User.h
//  Runtime(字典转模型KVC实现)
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *profile_image_url;

@property (nonatomic, assign) BOOL vip;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger mbrank;

@property (nonatomic, assign) NSInteger mbtype;

@end
