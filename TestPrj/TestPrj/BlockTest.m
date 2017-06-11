//
//  BlockTest.m
//  TestPrj
//
//  Created by gangpeng shu on 2017/6/9.
//  Copyright © 2017年 gangpeng shu. All rights reserved.
//

#import "BlockTest.h"

@implementation BlockTest
- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}
- (void)setBlock:(void (^)(NSString *))Block {
    _Block = Block;
    if (self.Block) {
        self.Block(@"Block!");
    }
}

@end
