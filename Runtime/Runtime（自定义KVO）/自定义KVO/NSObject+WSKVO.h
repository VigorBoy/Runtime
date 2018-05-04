//
//  NSObject+WSKVO.h
//  自定义KVO
//
//  Created by 马文帅 on 2017/10/26.
//  Copyright © 2017年 mawenshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WSKVOBlock)(NSDictionary * _Nonnull change);

@interface NSObject (WSKVO)

- (void)ws_observerkeyPath:(NSString *_Nonnull)keyPath options:(NSKeyValueObservingOptions)options block:(WSKVOBlock _Nonnull )block;

@end
