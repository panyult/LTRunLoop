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

+ (instancetype)sourceTaskWithPeddingData:(id)data
                                sourceHandler:(id<RunLoopSourceHandler>)sourceHandler
{
    return [self sourceTaskWithPeddingData:data
                             sourceHandler:sourceHandler
                  orSourceHandlerClassName:nil
                                completion:nil];
}

+ (instancetype)sourceTaskWithPeddingData:(id)data
                     sourceHandlerClassName:(NSString *)sourceHandlerClassName
{
    return [self sourceTaskWithPeddingData:data sourceHandlerClassName:sourceHandlerClassName completion:nil];
}

+ (instancetype)sourceTaskWithPeddingData:(id)data
                   sourceHandlerClassName:(NSString *)sourceHandlerClassName
                               completion:(SourceTaskCompletonBlock)completion
{
    return [self sourceTaskWithPeddingData:data
                             sourceHandler:nil
                  orSourceHandlerClassName:sourceHandlerClassName
                                completion:completion];
}

+ (instancetype)sourceTaskWithPeddingData:(id)data
                                sourceHandler:(id<RunLoopSourceHandler>)sourceHandler
                     orSourceHandlerClassName:(NSString *)sourceHandlerClassName
                               completion:(SourceTaskCompletonBlock)completion
{
    LTSourceTask *task = [[self alloc] init];
    task.peddingData = data;
    task.sourceHandler = sourceHandler;
    task.sourceHandlerClassName = sourceHandlerClassName;
    task.completionBlock = completion;
    return task;
}

@end
