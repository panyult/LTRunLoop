//
//  LTSourceTaskTest.m
//  LTRunLoopTests
//
//  Created by panyu_lt on 2017/12/31.
//

#import "LTTestCase.h"
#import "LTSourceTask.h"

@interface LTSourceTaskTest : LTTestCase<LTRunLoopSourceHandler>

@end

@implementation LTSourceTaskTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSourceTaskWithPeddingData_useObject
{
    NSString *data = @"LTSourceTask_test_useObject";
    LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:data sourceHandler:self];
    XCTAssertNotNil(task,@"fail to create task");
    XCTAssertTrue(task.peddingData && [task.peddingData isEqualToString:data],@"task show");
}

//- (void)object_runLoopSourceHandled:(LTSourceData *)sourceData
//{
//    NSLog(@"testSourceTaskWithPeddingData_useObject,do nothing");
//}

- (void)testSourceTaskWithPeddingData_useClass
{
    NSString *data = @"LTSourceTask_test_useClass";
    LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:data
                                          sourceHandlerClassName:NSStringFromClass(LTSourceTaskTest.class)
                                                      completion:^(LTSourceData *sourceData) {
                                                          NSLog(@"LTSourceTask_class_completion_block");
    }];
    XCTAssertNotNil(task,@"fail to create task");
    XCTAssertTrue(task.peddingData && [task.peddingData isEqualToString:data],@"task show");
    XCTAssertNotNil(task.completionBlock,@"comletionblock should not be nil here !");
    
    task = nil;
    task = [LTSourceTask sourceTaskWithPeddingData:data
                                          sourceHandlerClassName:NSStringFromClass(LTSourceTaskTest.class)];
    XCTAssertNotNil(task,@"fail to create task");
    XCTAssertTrue(task.peddingData && [task.peddingData isEqualToString:data],@"task show");
}

//+ (void)class_runLoopSourceHandled:(LTSourceData *)sourceData
//{
//    NSLog(@"testSourceTaskWithPeddingData_useClass,,do nothing");
//}



@end
