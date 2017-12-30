//
//  RunLoopSource.m
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import "RunLoopSource.h"
#import "DataChecker.h"
#import <objc/runtime.h>
#import <objc/message.h>

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
    CFRunLoopSourceContext  context = {0, (__bridge void *)self, NULL, NULL, NULL, NULL, NULL,
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

- (void)addTask:(LTSourceTask *)task
{
    if (!task || !task.peddingData) {
        return;
    }
    [self.dataLock lock];
    [self.dataArray addObject:task];
    [self.dataLock unlock];
}

- (void)removeTask:(LTSourceTask *)task
{
    [self.dataLock lock];
    [self.dataArray removeObject:task];
    [self.dataLock unlock];
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop
{
    CFRunLoopSourceSignal(_inputSource);
    CFRunLoopWakeUp(runloop);
}

#pragma mark - run loop callback

void handleDataAccordingTask(LTSourceData *data, LTSourceTask *task)
{
    if (task.sourceHandler && [task.sourceHandler respondsToSelector:@selector(object_runLoopSourceHandled:)]) {
        
        [task.sourceHandler object_runLoopSourceHandled:data];
        
    }
    else if(![DataChecker isStringEmptyOrNil:task.sourceHandlerClassName]) {
        
        Class handlerClass = NSClassFromString(task.sourceHandlerClassName);
        
        if (handlerClass && class_conformsToProtocol(handlerClass, @protocol(RunLoopSourceHandler))) {
            
            [[handlerClass class] performSelector:@selector(class_runLoopSourceHandled:) withObject:data];
            
        }
    }
    
}

void handleSource(void *info, CFRunLoopRef rl, CFStringRef mode,RunLoopSourceHandleType handleType)
{
    RunLoopSource* source = (__bridge RunLoopSource*)info;
    
    LTSourceData *data = [[LTSourceData alloc] init];
    data.handleType = handleType;
    if (source && ![DataChecker isArrayEmptyOrNil:source.dataArray]) {
        
        LTSourceTask *task = source.dataArray.firstObject;
        
        if (task && [task isKindOfClass:[LTSourceTask class]]) {
            
            data.peddingData = task.peddingData;

            handleDataAccordingTask(data, task);
            
            if (task.completionBlock) {
                task.completionBlock(data);
            }

        }
        
        [source removeTask:task];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLTRunLoopSourceHandleNotification object:data];

}

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    handleSource(info,rl,mode,RunLoopSourceHandleTypeWillScheduled);
}

void RunLoopSourcePerformRoutine (void *info)
{
    handleSource(info,NULL,NULL,RunLoopSourceHandleTypeHandled);
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    handleSource(info,rl,mode,RunLoopSourceHandleTypeCanceled);
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
