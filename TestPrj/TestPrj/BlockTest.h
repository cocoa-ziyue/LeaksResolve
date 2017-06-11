//
//  BlockTest.h
//  TestPrj
//
//  Created by gangpeng shu on 2017/6/9.
//  Copyright © 2017年 gangpeng shu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockTest : NSObject

@property (copy, nonatomic) void (^Block) (NSString *);

@end
