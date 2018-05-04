//
//  ViewController.m
//  自定义KVO
//
//  Created by 马文帅 on 2017/10/16.
//  Copyright © 2017年 mawenshuai. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "NSObject+Extension.h"
#import "NSObject+WSKVO.h"

@interface ViewController ()
@property (nonatomic, strong) Student *s1;
@property (nonatomic, strong) Student *s2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    _s1 = [[Student alloc] init];
    _s2 = [[Student alloc] init];
    
    //block回调
    [_s1 ws_observerkeyPath:@"score" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(NSDictionary * _Nonnull change) {
        NSLog(@"old=%@ new=%@", change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
    }];
    
    //使用自定义方法实现kvo监听
    [_s2 ws_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath=%@ old=%@ new=%@", keyPath, change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static NSInteger num = 0;
    num++;
    
    _s1.score = @(num);
    _s2.name = [NSString stringWithFormat:@"%zd", num];
}

@end
