//
//  ParametrizedTestCase.h
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/26.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface _SelectedTestCase : NSObject
@property(strong, nonatomic) NSString* _name;
- (instancetype)initWithName:(NSString*)name;
@end

@interface ParametrizedTestCase : XCTestCase
@property(nonatomic) NSString* testName;
- (void)beforeAll;
- (NSArray<_SelectedTestCase *> *)_allowedTestNames;
@end

NS_ASSUME_NONNULL_END
