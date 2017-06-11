//
//  TimerTest.m
//  TestPrj
//
//  Created by gangpeng shu on 2017/6/9.
//  Copyright © 2017年 gangpeng shu. All rights reserved.
//

#import "TimerTest.h"

@interface TimerTest()
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation TimerTest

-(instancetype)init {
    if (self = [super init]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer)
                                                                userInfo:nil repeats:NO];
    }
    return self;
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)handleTimer {
    NSLog(@"say: Hi!");
}

- (void)dealloc {
    [self stopTimer];
    NSLog(@"[TimerTest class] is dealloced");
}

@end
