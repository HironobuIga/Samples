//
//  ClassA.m
//  SampleProject
//
//  Created by 伊賀裕展 on 2017/10/30.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

#import "ClassA.h"

@implementation ClassA

- (void)functionA {
    NSLog(@"functionA Superclass");
    [self functionB];
}

- (void)functionB {
    NSLog(@"functionB Superclass");
}

@end
