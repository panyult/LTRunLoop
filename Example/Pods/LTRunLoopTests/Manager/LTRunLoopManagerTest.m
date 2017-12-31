//
//  LTRunLoopManagerTest.m
//  LTRunLoopTests
//
//  Created by panyu_lt on 2017/12/31.
//

#import "LTTestCase.h"
#import "LTRunLoopManager.h"
@class LTRunLoopManagerTest;
static NSString *const kLTSourceTask_TestData = @"LTSourceTask_test_useObject";

LTRunLoopManagerTest *_LTRunLoopManagerTest = nil;

@interface LTRunLoopManagerTest : LTTestCase<LTRunLoopSourceHandler>
@property (nonatomic, strong) XCTestExpectation *addSourceTaskUseObjectHandleException;
@property (nonatomic, strong) XCTestExpectation *addSourceTaskUseClassHandleException;

@end

@implementation LTRunLoopManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testManager
{
   LTRunLoopManager *manager = [LTRunLoopManager manager];
    XCTAssertNotNil(manager,@"LTRunLoopManager instance should not be nil");
}

- (void)testAddSourceTaskUseObjectHandle
{
    if (![LTRunLoopManager manager].isWorkerThreadExcuting) {
        [[LTRunLoopManager manager] start];
    }
    
    self.addSourceTaskUseObjectHandleException = [self expectationWithDescription:@"addSourceTaskUseObjectHandleException success!"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        NSString *data = kLTSourceTask_TestData;
        LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:data sourceHandler:self];
        
        [[LTRunLoopManager manager] addSourceTask:task];
        
    });
    [self waitForExpectations:@[self.addSourceTaskUseObjectHandleException] timeout:2.0];

}

- (void)object_runLoopSourceHandled:(LTSourceData *)sourceData
{
    if (sourceData.peddingData && [sourceData.peddingData isEqualToString:kLTSourceTask_TestData]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.addSourceTaskUseObjectHandleException fulfill];
            self.addSourceTaskUseObjectHandleException = nil;
        });
    }
}

- (void)testAddSourceTaskUseClassHandle
{
    if (![LTRunLoopManager manager].isWorkerThreadExcuting) {
        [[LTRunLoopManager manager] start];
    }
    _LTRunLoopManagerTest = self;
    self.addSourceTaskUseClassHandleException = [self expectationWithDescription:@"addSourceTaskUseClassHandleException success!"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *data = kLTSourceTask_TestData;
        LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:data sourceHandlerClassName:NSStringFromClass(self.class)];
        
        [[LTRunLoopManager manager] addSourceTask:task];
        
    });
    [self waitForExpectations:@[self.addSourceTaskUseClassHandleException] timeout:2.0];

}

+ (void)class_runLoopSourceHandled:(LTSourceData *)sourceData
{
    if (sourceData.peddingData && [sourceData.peddingData isEqualToString:kLTSourceTask_TestData]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_LTRunLoopManagerTest.addSourceTaskUseClassHandleException fulfill];
            _LTRunLoopManagerTest.addSourceTaskUseClassHandleException = nil;
            _LTRunLoopManagerTest = nil;
        });
    }
}

@end
