//
//  TestModel.h
//  Runtime（自动归档）
//
//  Created by    🐯 on 16/7/25.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSNumber *phoneNumber;
@property (nonatomic, copy) NSNumber *height;
@property (nonatomic, strong) NSDictionary *info;
@end
