//
//  NSObject+Extension.h
//  自定义KVO
//
//  Created by 马文帅 on 2017/10/16.
//  Copyright © 2017年 mawenshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (void)ws_addObserver:(NSObject *_Nonnull)observer forKeyPath:(NSString *_Nonnull)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
