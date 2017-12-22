//
//  RunLoopSource.m
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import "RunLoopSource.h"

@interface RunLoopSource()
    
@property (nonatomic, assign) CFRunLoopSourceRef inputSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSLock *dataLock;

@end

@implementation RunLoopSource

#pragma mark - handler method declaration
    
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);
void RunLoopSourcePerformRoutine (void *info);
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);
    
#pragma mark - life cycle
    
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    CFRunLoopSourceContext    context = {0, (__bridge void *)self, NULL, NULL, NULL, NULL, NULL,
        &RunLoopSourceScheduleRoutine,
        &RunLoopSourceCancelRoutine,
        &RunLoopSourcePerformRoutine};
    
    _inputSource = CFRunLoopSourceCreate(NULL, 0, &context);
    _dataArray = [[NSMutableArray alloc] init];
}

- (void)addToCurrentRunLoop
{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, _inputSource, kCFRunLoopDefaultMode);
}

#pragma mark -

- (void)addPeddingData:(id)data
{
    if (!data) {
        return;
    }
    [self.dataLock lock];
    [self.dataArray addObject:data];
    [self.dataLock unlock];
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop
{
    CFRunLoopSourceSignal(_inputSource);
    CFRunLoopWakeUp(runloop);
}

#pragma mark - run loop callback

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    NSLog(@"-- source will be scheduled to run loop-->");

}

void RunLoopSourcePerformRoutine (void *info)
{
    RunLoopSource*  obj = (__bridge RunLoopSource*)info;
    if (obj && obj.dataArray && obj.dataArray.count > 0) {
        id data = obj.dataArray.firstObject;
        if (data) {
//            [TaskHandler handleData:data];
//        TODO:lt use Notification to let  manager know something hanppened
        }
        
        [obj.dataLock lock];
        
        [obj.dataArray removeObject:data];
        
        [obj.dataLock unlock];
    }
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    NSLog(@"-- source will be Canceled -->");
}

#pragma mark - getters and setters

- (NSLock *)dataLock
{
    if (!_dataLock) {
        _dataLock = [[NSLock alloc] init];
        _dataLock.name = @"LTSourceDataLock";
    }
    return _dataLock;
}

@end
