//
//  LTTestCase.m
//  LTRunLoopTests
//
//  Created by panyu_lt on 2017/12/31.
//

#import "LTTestCase.h"


@implementation LTTestCase

- (void)setUp {
    [super setUp];
    self.commonTimeout = 5.0;
}

- (void)tearDown {
    [super tearDown];
}

- (void)waitForExpectationsWithCommonTimeout {
    [self waitForExpectationsWithCommonTimeoutUsingHandler:nil];
}

- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    [self waitForExpectationsWithTimeout:self.commonTimeout handler:handler];
}


@end
