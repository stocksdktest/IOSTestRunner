//
//  ParametrizedTestCase.m
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/26.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

#import "ParametrizedTestCase.h"

@implementation _SelectedTestCase
- (instancetype)initWithName:(NSString*)name {
    self = [super init];
    self._name = name;
    return self;
}
@end

@implementation ParametrizedTestCase
- (id)initWithInvocation:(NSInvocation *)invocation {
    self = [super initWithInvocation:invocation];
    printf("testName: %s\n", [self.testName UTF8String]);
    NSArray<_SelectedTestCase *> *cases = [self _allowedTestNames];
    for (_SelectedTestCase * item in cases) {
        if ([self.testName isEqualToString:item._name]) {
            return self;
        }
    }
    return nil;
}

- (NSArray<_SelectedTestCase *> *)_allowedTestNames {
    return @[];
}

@end
