//
//  NextViewController.m
//  TestPrj
//
//  Created by gangpeng shu on 2017/6/9.
//  Copyright © 2017年 gangpeng shu. All rights reserved.
//

#import "NextViewController.h"
#import "BlockTest.h"
#import "extobjc.h"

@interface NextViewController ()

@property (nonatomic,strong) BlockTest *test;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) NSDictionary *dict;

@end

@implementation NextViewController

#pragma mark
#pragma mark----- life cycle -----

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor redColor];
    self.btn.frame = CGRectMake(0, 0, 100, 50);
    [self.view addSubview:self.btn];
    self.btn.center  = self.view.center;
   
    //3.block内存泄露
//    self.test = [[BlockTest alloc]init];
//    
//    self.test.Block = ^(NSString *str){
//        NSLog(@"Block is %@",str);
//        [self.btn setTitle:str forState:UIControlStateNormal];
//    };
//    
//    if (self.testBlock) {
//        self.testBlock();
//    }
    
    //4.NSNotification内存泄露
//    @weakify(self);
    [[NSNotificationCenter defaultCenter] addObserverForName:@"nextVcPost" object:nil queue:nil usingBlock:^(NSNotification *note) {
//        @strongify(self);
//        self.dict = note.userInfo;
//        if (self.dict) {
            [self doNotifyThing];
//        }
    }];

    //5.delegate内存泄露
}

- (void)doNotifyThing {
//    NSLog(@"self.dict is %@",self.dict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"NextViewController被释放了");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark
#pragma mark----- setup & configuration -----



#pragma mark
#pragma mark----- private methods -----



#pragma mark
#pragma mark----- getters and setters -----

- (void)tongzhi:(NSNotification *)text{
    NSLog(@"－－－－－接收到通知------");
}

@end
