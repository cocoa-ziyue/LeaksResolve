//
//  ViewController.m
//  TestPrj
//
//  Created by gangpeng shu on 2017/6/9.
//  Copyright © 2017年 gangpeng shu. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "TimerTest.h"
#import "extobjc.h"

@interface ViewController ()
@property (nonatomic,strong) TimerTest *timer;
@property (nonatomic,strong) UIButton *nextBtn;
@property (nonatomic,strong) UIButton *nextBtn1;
@property (nonatomic,strong) UIButton *nextBtn2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //内存泄露:如果程序运行时一直分配内存而不及时释放无用的内存，程序占用的内存越来越大，直到把系统分配给该APP的内存消耗殚尽，程序因无内存可用导致崩溃，这样的情况我们称之为内存泄漏。
    //内存泄露可能引发的问题:
    //1)内存消耗殆尽的时候，程序会因没有内存被杀死，即crash。
    //2)当内存快要用完的时候，会非常的卡顿
    //3)如果是ViewController没有释放掉，引起的内存泄露，还会引起其他很多问题，尤其是和通知相关的。没有被释放掉的ViewController还能接收通知，还会执行相关的动作，所以会引起各种各样的异常情况的发生。（这一点尤为重要，项目中重点关注）
    
    //常见的监测方法 ：
    //1.静态分析:通过静态分析我们可以最初步的了解到代码的一些不规范的地方和一些代码逻辑上的错误；
    //2.Leaks
    //3.MLeaksFinder
    
    //常见循环引用
    // 1.NSTimer:创建定时器时,当前控制器引用而定时器了(为什么因引用定时器?后续要用到这个定时器对象),在给定时器添加任务时,定时器保留了self(当前控制器).这里就出现了循环引用.
    // 解决方案：1.控制器不再引用定时器(不太可能) 2.定时器不再保留当前控制器(较为科学，直接停止掉即可)
//    self.timer =  [[TimerTest alloc]init];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [self.timer stopTimer];
//                        self.timer = nil;
//    });
    
    // 2.GCD计时器，使用GCD的定时器，要注意使用weakself。
    //    @weakify(self);
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_source_t gcdtimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //    dispatch_source_set_timer(gcdtimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    //    dispatch_source_set_event_handler(gcdtimer, ^{
    //        @strongify(self);
    //        [self doSomething];
    //    });
    //    dispatch_resume(gcdtimer);
    
    //3.VC的内存泄露。解决方法：想要知道ViewController有没有被释放，一个方法就是可以通过看ViewController有没有执行dealloc方法。
    self.nextBtn = [[UIButton alloc]init];
    _nextBtn.backgroundColor = [UIColor blackColor];
    [_nextBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.frame = CGRectMake(0,0,100,50);
    _nextBtn.center = self.view.center;
    
    [self.view addSubview:_nextBtn];
    
    self.nextBtn1 = [[UIButton alloc]init];
    _nextBtn1.backgroundColor = [UIColor redColor];
    [_nextBtn1 addTarget:self action:@selector(postNotify1) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn1.frame = CGRectMake(0,0,100,50);
    _nextBtn1.center = CGPointMake(self.view.center.x,self.view.center.y+100);
    [self.view addSubview:_nextBtn1];

    self.nextBtn2 = [[UIButton alloc]init];
    _nextBtn2.backgroundColor = [UIColor greenColor];
    [_nextBtn2 addTarget:self action:@selector(postNotify2) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn2.frame = CGRectMake(0,0,100,50);
    _nextBtn2.center = CGPointMake(self.view.center.x,self.view.center.y+200);
    [self.view addSubview:_nextBtn2];
}

- (void)goNext {
    NextViewController *nextVc = [[NextViewController alloc]init];
    
    //    nextVc.testBlock = ^(){
    //        NSLog(@"哈哈");
    //    };
    [self.navigationController pushViewController:nextVc animated:YES];
}

- (void)postNotify1 {
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    NSLog(@"发出了tongzhi通知");
}

- (void)postNotify2 {
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"nextVcPost" object:nil userInfo:@{@"name":@"张三"}];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    NSLog(@"发出了nextVcPost通知");
}

- (void)doSomething {
    NSLog(@"GCDtimer say:Hi!");
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [self.timer stopTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
