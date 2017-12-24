//
//  LTSourceTask.m
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/23.
//

#import "LTSourceTask.h"

@interface LTSourceTask()

@end

@implementation LTSourceTask
#pragma mark - life cycle

+ (instancetype)getASourceTaskWithPeddingData:(id)data
                                sourceHandler:(id<RunLoopSourceHandler>)sourceHandler
{
    return [self getASourceTaskWithPeddingData:data sourceHandler:sourceHandler orSourceHandlerClassName:nil];
}

+ (instancetype)getASourceTaskWithPeddingData:(id)data
                     sourceHandlerClassName:(NSString *)sourceHandlerClassName
{
    return [self getASourceTaskWithPeddingData:data sourceHandler:nil orSourceHandlerClassName:sourceHandlerClassName];
}

+ (instancetype)getASourceTaskWithPeddingData:(id)data
                                sourceHandler:(id<RunLoopSourceHandler>)sourceHandler
                     orSourceHandlerClassName:(NSString *)sourceHandlerClassName
{
    LTSourceTask *task = [[self alloc] init];
    task.peddingData = data;
    task.sourceHandler = sourceHandler;
    task.sourceHandlerClassName = sourceHandlerClassName;
    return task;
}

@end
