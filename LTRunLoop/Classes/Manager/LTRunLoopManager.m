//
//  LTRunLoopManager.m
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import "LTRunLoopManager.h"
#import "RunLoopContext.h"
#import "DataChecker.h"

static LTRunLoopManager *_manager;

static NSString *const kWorkerThreadName = @"LTRunLoopManager_WorkerThread";


@interface LTRunLoopManager()
/**
 Apple recommands that it's better to create a thread via GCD than NSThread, but here using NSThread to creat a thread, thus we can set a self-define name and other initializations for the thread ,which is helpful to debug.
 */
@property (nonatomic, strong) NSThread *workerThread;
@property (nonatomic, assign) CFRunLoopRef workerRunLoop;
@property (nonatomic, strong) NSMutableArray *runLoopContextArray;

@property (nonatomic, strong) NSMutableDictionary *dataToHandlerDictionary;
@end

@implementation LTRunLoopManager

#pragma mark - life cycle

+ (instancetype)manager
{
    if (!_manager) {
        _manager = [[self alloc] init];
    }
    return _manager;
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [super init];
        
        _workerThread = [[NSThread alloc] initWithTarget:_manager selector:@selector(startRunLoop) object:nil];
        _workerThread.name = kWorkerThreadName;
        
        _runLoopContextArray = [NSMutableArray array];
        _dataToHandlerDictionary = [NSMutableDictionary dictionary];
    });
    return _manager;
}

#pragma mark - bind handler class and data class

- (void)registerHandlerClassName:(NSString *)handlerClassName forDataClassName:(NSString *)dataClassName
{
    
    NSAssert(![DataChecker isStringEmptyOrNil:handlerClassName]
             && ![DataChecker isStringEmptyOrNil:dataClassName],
             @"handlerClassName or dataClassName can not be nil");
    
    [_dataToHandlerDictionary setObject:dataClassName forKey:handlerClassName];
}


#pragma mark - start the worker thread

- (void)start
{
    [_workerThread start];
}

- (void)startRunLoop
{
    BOOL done = NO;
    
    if (!_workerRunLoop) {
        _workerRunLoop = CFRunLoopGetCurrent();
    }
    
    RunLoopSource *runloopSource = [[RunLoopSource alloc] init];
    
    RunLoopContext *ctx = [[RunLoopContext alloc] initWithSource:runloopSource andRunLoop:_workerRunLoop];
    [_runLoopContextArray addObject:ctx];
    
    [runloopSource addToCurrentRunLoop];
    
    do
    {
        int result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, YES);
        
        switch (result) {
            case kCFRunLoopRunHandledSource:
            {
                NSLog(@"-----> success to handle source,result code : %d",result);
                break;
            }
            case kCFRunLoopRunStopped:
            case kCFRunLoopRunFinished:
            {
                done = YES;
                break;
            }
            default:
            break;
        }
    }
    while (!done);
    [self freeupSource];
}

- (void)freeupSource
{
    _workerRunLoop = NULL;
    _workerThread = nil;
    _runLoopContextArray = nil;
    _dataToHandlerDictionary = nil;
}

#pragma mark - manage tasks

- (void)addSourceTask:(LTSourceTask *)task
{
    if (!self.runLoopContextArray || self.runLoopContextArray.count == 0) {
        return;
    }
    
    RunLoopContext *ctx = self.runLoopContextArray.firstObject;
    RunLoopSource *source = ctx.runLoopSource;
    
    [source addTask:task];
    
    [source fireCommandsOnRunLoop:self.workerRunLoop];
}

@end
