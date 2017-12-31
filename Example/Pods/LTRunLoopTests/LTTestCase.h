//
//  LTTestCase.h
//  LTRunLoopTests
//
//  Created by panyu_lt on 2017/12/31.
//

#import <XCTest/XCTest.h>

@interface LTTestCase : XCTestCase

@property (nonatomic, assign) NSTimeInterval commonTimeout;


- (void)waitForExpectationsWithCommonTimeout;
- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler;
@end
